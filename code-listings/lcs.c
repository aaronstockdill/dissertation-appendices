#include <stdlib.h>
#include <stdio.h>

int lcs(char* a, int a_len, char* b, int b_len, char** out)
{
    int* grid = calloc((a_len + 1) * (b_len + 1), sizeof(int));
    int ravel = b_len + 1;

    for (int i=1; i < a_len + 1; i++) {
        for (int j=1; j < b_len + 1; j++) {
            if (a[i-1] == b[j-1]) {
                int l = grid[ravel * (i-1) + j-1];
                grid[ravel * i + j] = l + 1;
            } else {
                int l1 = grid[ravel * i + j - 1];
                int l2 = grid[ravel * (i-1) + j];
                if (l1 > l2)
                    grid[ravel * i + j] = l1;
                else
                    grid[ravel * i + j] = l2;
            }
        }
    }

    int ss_len = grid[ravel * a_len + b_len];
    *out = calloc((ss_len + 1), sizeof(char));
    int k = ss_len - 1;
    int i = a_len;
    int j = b_len;
    while (k >= 0) {
        if (a[i-1] == b[j-1]) {
            (*out)[k] = a[i-1];
            i--; j--; k--;
        } else {
            if (grid[ravel * i + j - 1] > grid[(i-1) * ravel + j])
                j--;
            else
                i--;
        }
    }
    free(grid);
    return ss_len;
}

int main(int argc, char** argv)
{
    char* a1 = "1234";
    char* b1 = "1224533324";
    char* s1 = "\0";
    lcs(a1, 4, b1, 10, &s1);
    puts(s1);
    free(s1);

    char* a2 = "thisisatest";
    char* b2 = "testing123testing";
    char* s2 = "\0";
    lcs(a2, 11, b2, 17, &s2);
    puts(s2);
    free(s2);

    return 0;
}
