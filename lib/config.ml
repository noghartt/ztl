let path_config_dir = Filename.concat (Sys.getenv "HOME") ".ztl"
let path_config_file = Filename.concat path_config_dir "config.json"

let make_config_dir () =
  if not (Sys.file_exists path_config_dir) then
    try
      Printf.printf "Creating config directory %s." path_config_dir;
      Sys.mkdir path_config_dir 0o755;
      Ok ()
    with _ -> Error "Failed to create config directory"
  else Ok ()
