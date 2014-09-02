open V1
open Lwt

module Main (C: CONSOLE)(RAND: RANDOM) = struct

let start console random =
  RAND.self_init() ;
  while true do
    C.log console (Printf.sprintf "%d" (RAND.int 2))
  done ;
  return ()
end
