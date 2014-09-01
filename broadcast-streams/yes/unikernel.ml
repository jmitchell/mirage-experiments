open Lwt

module Main (C: V1_LWT.CONSOLE) = struct

let start c =
  while true do
    C.log c "y"
  done ;
  return ()
end
