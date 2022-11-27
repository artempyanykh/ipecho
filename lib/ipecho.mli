(** Server that echoes IP addresses of clients *)

module Config = Config
module Error = Error

val greet : string -> string
(** Returns a greeting message.

    {4 Examples}

    {[
      print_endline @@ greet "Jane"
    ]} *)
