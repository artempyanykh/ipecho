module Config = Config
module Error = Error

let ipecho sockaddr reqd =
  let open Httpaf in
  let addr =
    match sockaddr with
    | Unix.ADDR_INET (addr, _) -> Unix.string_of_inet_addr addr
    | Unix.ADDR_UNIX _ -> "<unknown>"
  in
  let headers =
    Headers.of_list [ ("content-type", "text/plain"); ("connection", "close") ]
  in
  match Reqd.request reqd with
  | Request.{ meth = `GET; target = "/"; _ } ->
      Reqd.respond_with_string reqd (Response.create ~headers `OK) addr
  | _ ->
      Reqd.respond_with_string reqd
        (Response.create ~headers `Method_not_allowed)
        "Unsupported operation"

let request_handler sockaddr = ipecho sockaddr

let error_handler _sockaddr ?request:_ error start_response =
  let open Httpaf in
  let response_body = start_response Headers.empty in
  (match error with
  | `Exn exn ->
      Body.write_string response_body (Printexc.to_string exn);
      Body.write_string response_body "\n"
  | #Status.standard as error ->
      Body.write_string response_body (Status.default_reason_phrase error));
  Body.close_writer response_body

let create_handler =
  Httpaf_lwt_unix.Server.create_connection_handler ~request_handler
    ~error_handler

let run ~port =
  let open Lwt.Syntax in
  let addr = Unix.ADDR_INET (Unix.inet_addr_any, port) in
  Lwt.async (fun () ->
      let+ _ = Lwt_io.establish_server_with_client_socket addr create_handler in
      ());
  let forever, _ = Lwt.wait () in
  Lwt_main.run forever |> ignore
