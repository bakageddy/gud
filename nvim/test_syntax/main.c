#include <assert.h>
#include <stdlib.h>

typedef struct Node {
	int data;
	struct Node *next;
} Node;

typedef struct {
	Node *head;
	int count;
} List;

List* create(void) {
	List* temp = malloc(sizeof(List));
	assert(temp != NULL);
	temp -> head = NULL;
	temp -> count = 0;
	return temp;
}

void recursive_free(Node *n) {
	if (!n) {
		return;
	}
	recursive_free(n -> next);
	free(n);
}

void alloc_node(Node *n) {
	n = malloc(sizeof(*n));
	if (n == NULL) {
		return;
	}

	n -> data = 0;
	n -> next = NULL;
	return;
}

void delete(List* l) {
	if (l -> head) recursive_free(l -> head);
	free(l);
}

int main(void) {
	return 0;
}
