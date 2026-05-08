//Shriyans Singh 114807762
//Code was given by professor, I am just seeing how it works
#include <stdio.h>
// Bubble sort function (descending order)
void bubbleSort(int arr[], int n) {
    int i, j;
    for (i = 0; i < n - 1; i++) {
        for (j = 0; j < n - 1 - i; j++) {
            if (arr[j] < arr[j + 1]) {
                // swap
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
int main() {
    int v[] = {8, 100, 0, 3, 7, 9, 2, 7, -3, 0};
    int n = 10;
    printf("Sorted Array: ");
    // function call (matches your intent)
    bubbleSort(v, n);
    // print array
    for (int i = 0; i < n; i++) {
        printf("%d ", v[i]);
    }
    return 0;
}