#include <stdio.h>

extern int find_max(int* arr, int size);

void print_arr(int* arr, int size)
{
	printf("{");
	for (int i = 0; i < size; i++) {
		printf("%d", arr[i]);

		if (i != size - 1) {
			printf(", ");
		}
	}
	printf("}\n");
}

int main(void)
{
	int arr[] = {4, 2, 1, 5, 3};	
	int size = sizeof(arr) / sizeof(arr[0]);
	print_arr(arr, size);

	int max_value = find_max(arr, size);
	printf("Max: %d\n", max_value);
}
