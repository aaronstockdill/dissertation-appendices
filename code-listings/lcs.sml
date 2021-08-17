fun lcs xstring ystring =
    let
        val xl = String.size xstring;
        val yl = String.size ystring;
        val table = Array2.tabulate Array2.RowMajor
                                    (xl+1, yl+1, fn _ => 0);

        fun getTable (i, j) = Array2.sub(table, i, j);
        fun setTable (i, j) x = Array2.update(table, i, j, x);

        val _ =
            let fun loopy i j =
                    if j = (yl + 1) then ()
                    else (if String.sub(xstring, i-1) = String.sub(ystring, j-1)
                          then setTable (i, j) (getTable(i-1, j-1) + 1)
                          else setTable (i, j)
                                        (Int.max(getTable(i, j-1),
                                                 getTable(i-1, j)));
                          loopy i (j+1));
                fun loopx i = if i = (xl + 1)
                              then ()
                              else (loopy i 1; loopx (i+1));
            in loopx 1 end;

        fun reconstruct ans 0 _ _ = String.implode ans
          | reconstruct ans k i j =
            if (String.sub(xstring,i-1) = String.sub(ystring,j-1))
            then reconstruct (String.sub(xstring,i-1)::ans) (k-1) (i-1) (j-1)
            else if getTable(i, j-1) > getTable(i-1,j)
            then reconstruct ans k i (j-1)
            else reconstruct ans k (i-1) j;

        val solution = reconstruct [] (getTable(xl, yl)) xl yl;
    in solution end;


fun main () =
    let
        val _ = print (lcs "1234" "1224533324");
        val _ = print "\n";

        val _ = print (lcs "thisisatest" "testing123testing");
        val _ = print "\n";
    in 0 end;

main ();
