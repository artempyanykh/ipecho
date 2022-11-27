val term : int Cmdliner.Term.t
val handle_errors : (unit, Ipecho.Error.t) Result.t -> int
val envs : Cmdliner.Cmd.Env.info list
val exits : Cmdliner.Cmd.Exit.info list

module Syntax : sig
  val ( let+ ) : 'a Cmdliner.Term.t -> ('a -> 'b) -> 'b Cmdliner.Term.t

  val ( and+ ) :
    'a Cmdliner.Term.t -> 'b Cmdliner.Term.t -> ('a * 'b) Cmdliner.Term.t
end
