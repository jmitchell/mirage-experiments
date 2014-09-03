open V1
open Lwt

module Main (C: CONSOLE)(RAND: RANDOM) = struct

let new_uuid () =
  let uuid_version = 4 in
  let hex_digits =
    let inclusive_range a b =
      let rec aux i acc =
        if i > b then acc else aux (i + 1) (i :: acc)
      in
      aux a []
    in
    List.map Char.chr
             (List.append (inclusive_range (Char.code '0')
                                           (Char.code '9'))
                          (inclusive_range (Char.code 'a')
                                           (Char.code 'f')))
  in
  let sample xs =
    match List.length xs with
      0 -> failwith "no elements to sample"
    | n -> List.nth xs (RAND.int n)
  in
  let special_hex = sample ['8'; '9'; 'a'; 'b'] in
  let hex_string n =
    let rec aux i acc =
      if i <= 0 then acc else aux (i - 1) (sample hex_digits :: acc)
    in
    String.concat "" (List.map Char.escaped (aux n []))
  in
  String.concat "-" [ hex_string 8 ;
                      hex_string 4 ;
                      String.concat "" [ string_of_int uuid_version ; hex_string 3 ] ;
                      String.concat "" [ Char.escaped special_hex ; hex_string 3 ] ;
                      hex_string 12 ]

let start console random =
  RAND.self_init () ;
  while true do
    C.log console (new_uuid ())
  done ;
  return ()
end
