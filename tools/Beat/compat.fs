module Compat

(* funcs from FSharp.Compatibility.OCaml, but that isn't compatibile with the FSPowerPack *)

open System
open System.Collections.Generic
open System.Diagnostics

let print_endline (s:string) = printfn "%s" s

let private indexNotFound () =
    raise <| KeyNotFoundException "An index satisfying the predicate was not found in the collection"

let rec mem_assoc x l =
    match l with
    | [] -> false
    | ((h,_)::t) -> x = h || mem_assoc x t

let rec assoc x l =
    match l with
    | [] -> indexNotFound()
    | ((h,r)::t) -> if x = h then r else assoc x t

/// Convert the given string to an integer.
/// The string is read in decimal (by default) or in hexadecimal (if it begins with 0x or 0X),
/// octal (if it begins with 0o or 0O), or binary (if it begins with 0b or 0B).
let int_of_string (str : string) : int =
    // TODO : This function should also check the parsed value -- if it's
    // outside the range of a 31-bit integer, then fail in that case too.
    if str.StartsWith ("0x", StringComparison.OrdinalIgnoreCase) then
        try Convert.ToInt32 (str.[2..], 16)
        with _ -> failwith "int_of_string"
    elif str.StartsWith ("0o", StringComparison.OrdinalIgnoreCase) then
        try Convert.ToInt32 (str.[2..], 8)
        with _ -> failwith "int_of_string"
    elif str.StartsWith ("0b", StringComparison.OrdinalIgnoreCase) then
        try Convert.ToInt32 (str.[2..], 2)
        with _ -> failwith "int_of_string"
    else
        match Int32.TryParse str with
        | true, value ->
            value
        | false, _ ->
            failwith "int_of_string"

/// Return the string representation of an integer, in decimal.
let inline string_of_int (value : int) : string =
    value.ToString ()

/// Return the ASCII code of the argument.
let code (c : char) : int =
    // NOTE : The OCaml documentation for this function does not specify what to do
    // if the character is a non-ASCII (i.e., Unicode) character; until the specific
    // behavior of the function can be determined, we'll raise an exception here,
    // as done in the 'Char.chr' function.
    if int c > int Byte.MaxValue then
        raise <| System.ArgumentException "Char.code"

    int c

let private test_null arg =
    match arg with
    | null ->
        raise <| System.ArgumentNullException "arg"
    | _ -> ()

let lowercase (s : string) =
    test_null s
    s.ToLowerInvariant ()

let uncapitalize (s : string) =
    test_null s
    if s.Length = 0 then ""
    else (lowercase s.[0..0]) + s.[1 .. s.Length - 1]
