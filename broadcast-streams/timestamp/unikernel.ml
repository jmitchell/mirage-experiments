open V1
open Lwt

module Main (C: CONSOLE)(CLK: CLOCK) = struct

let current_time () =
  let tm_to_string ({
                       tm_sec = sec; tm_min = min; tm_hour = hour;
                       tm_mday = mday; tm_mon = mon; tm_year = year;
                       tm_wday = wday; tm_yday = yday; tm_isdst = isdst
                     } : CLK.tm) =
    Printf.sprintf "[%d-%d-%d %d:%d:%d]" (year+1900) (mon+1) mday hour min sec
  in
  let (|>) x f = f x in
  CLK.time () |> CLK.gmtime |> tm_to_string

let start console clock =
  while true do
    C.log console (current_time ())
  done ;
  return ()
end
