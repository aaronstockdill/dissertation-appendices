#include <stdlib.h>
#include <stdio.h>

struct tree_s {
    int value;
    struct tree_s* left;
    struct tree_s* right;
};

int inorder(struct tree_s* t, int** out)
{
    if (t == NULL)
        return 0;
    int* left_traversal = NULL;
    int* right_traversal = NULL;
    int left_size = inorder(t->left, &left_traversal);
    int right_size = inorder(t->right, &right_traversal);

    (*out) = malloc((left_size + right_size + 1) * sizeof(int));
    int k = 0;
    for (int i=0; i < left_size; i++)
        (*out)[k++] = left_traversal[i];
    (*out)[k++] = t->value;
    for (int j=0; j < right_size; j++)
        (*out)[k++] = right_traversal[j];
    free(left_traversal);
    free(right_traversal);
    return k;
}

int main(int argc, char** argv)
{
    struct tree_s t1 = {
        .value = 1,
        .left = NULL,
        .right = NULL
    };
    struct tree_s t3 = {
        .value = 3,
        .left = NULL,
        .right = NULL
    };
    struct tree_s t5 = {
        .value = 5,
        .left = NULL,
        .right = NULL
    };
    struct tree_s t7 = {
        .value = 7,
        .left = NULL,
        .right = NULL
    };
    struct tree_s t2 = {
        .value = 2,
        .left = &t1,
        .right = &t3
    };
    struct tree_s t6 = {
        .value = 6,
        .left = &t5,
        .right = &t7
    };
    struct tree_s t4 = {
        .value = 4,
        .left = &t2,
        .right = &t6
    };

    struct tree_s* t = &t4;
    int* traversal = NULL;
    int traversal_size = inorder(t, &traversal);
    for (int i=0; i < traversal_size; i++)
        printf("%d ", traversal[i]);
    puts("");
    return 0;
}
