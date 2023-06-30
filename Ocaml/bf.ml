let data = Array.make 30000 0
let p = ref 0
let s = ref ""

let rec process_brainfuck loc =
  let t = ref loc in
  let rec loop () =
    if String.length !s > !t then begin
      let c = String.get !s !t in
      if c = '+' then (
        data.(!p) <- data.(!p) + 1
      ) else if c = '-' then (
        data.(!p) <- data.(!p) - 1
      ) else if c = '>' then (
        p := !p + 1
      ) else if c = '<' then (
        p := !p - 1
      ) else if c = '.' then (
        print_char (Char.chr data.(!p))
      ) else if c = ',' then (
        let chr = input_char stdin in
        data.(!p) <- Char.code chr
      ) else if c = '[' then (
        t := process_brainfuck (!t + 1)
      ) else if c = ']' && data.(!p) != 0 then (
        if data.(!p) != 0 then (
          t := process_brainfuck loc
        )
      )
      else ();
      t := !t + 1;
      loop ()
    end
    else
      ()
  in
  loop ();
  String.length !s

let () =
  let filename = Sys.argv.(1) in
  let ic = open_in filename in
  try
    let file_content = really_input_string ic (in_channel_length ic) in
    close_in ic;
    s := file_content;
    let _ = process_brainfuck 0 in
    ()
  with exn ->
    close_in_noerr ic;
    raise exn

