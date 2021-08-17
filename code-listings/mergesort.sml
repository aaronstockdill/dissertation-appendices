fun split [] = ([], [])
  | split [x] = ([x], [])
  | split (x::y::zs) = let val (xs, ys) = split(zs)
                       in (x::xs, y::ys) end;

fun merge [] ys = ys
  | merge xs [] = xs
  | merge (x::xs) (y::ys) =
    if x <= y
    then x::(merge xs (y::ys))
    else y::(merge (x::xs) ys);

fun mergesort [] = []
  | mergesort [x] = [x]
  | mergesort lst =
    let val (xs, ys) = split(lst);
        val (xs', ys') = (mergesort(xs), mergesort(ys));
    in merge xs' ys' end;

fun main () =
    let val test1 = [3, 2, 1, 4, 5];
        val _ = print (String.concatWith " " (map Int.toString
                                                  (mergesort test1))
                       ^ "\n");
        val test2 = [5, 5, 3, 2, 7, 9, 6, 7, 1, 10, 8, 4];
        val _ = print (String.concatWith " " (map Int.toString
                                                  (mergesort test2))
                       ^ "\n");
    in 0 end;

main ();
