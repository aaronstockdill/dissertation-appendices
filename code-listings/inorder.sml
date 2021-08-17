datatype 'a tree = Leaf
                 | Branch of 'a * 'a tree * 'a tree;

fun inorder Leaf = []
  | inorder (Branch (v, l, r)) = (inorder l) @ (v::(inorder r));
(* List.concat([inorder l, [v], inorder r]); *)

fun main () =
    let val t = Branch (4,
                        Branch (2,
                                Branch (1, Leaf, Leaf),
                                Branch (3, Leaf, Leaf)),
                        Branch (6,
                                Branch (5, Leaf, Leaf),
                                Branch (7, Leaf, Leaf)));
        val _ = print ((String.concatWith " " (map Int.toString
                                                   (inorder t)))
                       ^ "\n");
    in 0 end;

main ();
