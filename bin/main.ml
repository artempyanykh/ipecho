open Cmdliner

let run ~port =
  Ipecho.run ~port;
  Ok ()

(* Command line interface *)

let doc = "Server that echoes IP addresses of clients"
let sdocs = Manpage.s_common_options
let exits = Common.exits
let envs = Common.envs

let man =
  [
    `S Manpage.s_description;
    `P "Server that echoes IP addresses of clients";
    `S Manpage.s_commands;
    `S Manpage.s_common_options;
    `S Manpage.s_exit_status;
    `P "These environment variables affect the execution of $(mname):";
    `S Manpage.s_environment;
    `S Manpage.s_bugs;
    `P "File bug reports at $(i,%%PKG_ISSUES%%)";
    `S Manpage.s_authors;
  ]

let term =
  let open Common.Syntax in
  let+ _ = Common.term
  and+ port =
    let doc = "The port to run the server on." in
    let docv = "PORT" in
    Arg.(required & pos 0 (some int) None & info [] ~doc ~docv)
  in
  run ~port |> Common.handle_errors

let info =
  Cmd.info "ipecho" ~version:"%%VERSION%%" ~doc ~sdocs ~exits ~man ~envs

let () = Cmd.eval' (Cmd.v info term) |> Stdlib.exit
