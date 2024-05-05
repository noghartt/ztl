
open Minttea

type model = {
  choices : (string * [ `selected | `unselected ]) list;
  (* current position of cursor *)
  cursor : int;
}

let initial_model =
  {
    cursor = 0;
    choices =
      [
        ("Buy empanadas 🥟", `unselected);
        ("Buy ice cream 🍦", `unselected);
        ("Buy milk 🥛", `unselected);
      ];
  }

let init _model = Command.Noop

let update event model =
  match event with
  | Event.KeyDown (Key "q" | Escape) -> (model, Command.Quit)
  | Event.KeyDown (Up | Key "k") ->
      let cursor =
        if model.cursor = 0 then List.length model.choices - 1
        else model.cursor - 1
      in
      (* merge record with *)
      ({ model with cursor }, Command.Noop)
  | Event.KeyDown (Down | Key "j") ->
      let cursor =
        if model.cursor = List.length model.choices - 1 then 0
        else model.cursor + 1
      in
      ({ model with cursor }, Command.Noop)
  | Event.KeyDown (Enter | Space) ->
      let toggle status =
        match status with 
        | `selected -> `unselected
        | `unselected -> `selected
      in
      let choices =
        List.mapi
          (fun idx (name, status) ->
            let status = if idx = model.cursor then toggle status else status in
            (name, status))
          model.choices
      in
      ({ model with choices }, Command.Noop)
  | _ -> (model, Command.Noop)

let view model =
  let options =
    model.choices
    |> List.mapi (fun idx (name, checked) ->
           let cursor = if model.cursor = idx then ">" else " " in
           let checked = if checked = `selected then "x" else " " in
           Format.sprintf "%s [%s] %s" cursor checked name)
    |> String.concat "\n"
  in
  Format.sprintf
    {|
What should we buy at the market?

%s

Press q to quite.
    |}
    options

let () = 
  Minttea.app ~init ~update ~view ()
  |> Minttea.start ~initial_model
