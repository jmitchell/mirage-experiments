open Mirage

let main =
  foreign "Unikernel.Main" (console @-> random @-> job)

let () =
  register "console" [ main $ default_console $ default_random ]
