open Config

let path_store = Filename.concat path_config_dir "store.json"

type task_status = [`Todo | `Done] [@@deriving yojson]
type tags = string list [@@deriving yojson]

module Store : sig
  type t = {
    tasks : (task_status * string * tags) list;
  }

  val create : unit -> t
  val save : t -> unit
end = struct
  type t = {
    tasks : (task_status * string * tags) list;
  } [@@deriving yojson]

  let create () = { tasks = [] }

  let save store =
    let oc = open_out path_store in
    let json = Yojson.Safe.to_string (to_yojson store) in
    output_string oc json;
    close_out oc
end

let make_store () =
  if not (Sys.file_exists path_config_dir) then
    match make_config_dir () with
    | Ok () ->
      let store = Store.create () in
      Store.save store
    | Error e ->
      Printf.eprintf "Error: %s\n" e;
      exit 1