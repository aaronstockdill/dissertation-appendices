#include <stdlib.h>
#include <stdio.h>

void merge(int* list_1, int len_1, int* list_2, int len_2, int** out)
{
    int i = 0;
    int j = 0;
    int k = 0;
    (*out) = malloc((len_1 + len_2) * sizeof(int));

    while (i < len_1 && j < len_2) {
        if (list_1[i] <= list_2[j])
            (*out)[k++] = list_1[i++];
        else
            (*out)[k++] = list_2[j++];
    }
    for (int i2=i; i2 < len_1; i2++)
        (*out)[k++] = list_1[i2];
    for (int j2=j; j2 < len_2; j2++)
        (*out)[k++] = list_2[j2];
}

void mergesort_(int* list, int length)
{
    if (length <= 1)
        return;

    int mid = (length + 1) / 2;
    mergesort_(list, mid);
    mergesort_(&(list[mid]), length-mid);
    int* new = NULL;
    merge(list, mid, &(list[mid]), length-mid, &new);
    for (int i=0; i < length; i++)
        list[i] = new[i];
    free(new);
}

int main(int argc, char** argv)
{
    int test1[5] = {3, 2, 1, 4, 5};
    mergesort_(test1, 5);
    for (int i=0; i<5; i++)
        printf("%d ", test1[i]);
    puts("");

    int test2[12] = {5, 5, 3, 2, 7, 9, 6, 7, 1, 10, 8, 4};
    mergesort_(test2, 12);
    for (int i=0; i<12; i++)
        printf("%d ", test2[i]);
    puts("");

    return 0;
}
