// A class for an expandable stack. There is already a stack class in the
// Standard C++ Library; this class serves as an exercise for students to
// learn the mechanics of building generic, expandable, data structures
// from scratch with smart pointers.

#include <stdexcept>
#include <string>
#include <memory>
using namespace std;

// A stack object wraps a low-level array indexed from 0 to capacity-1 where
// the bottommost element (if it exists) will be in slot 0. The member top is
// the index of the slot above the top element, i.e. the next available slot
// that an element can go into. Therefore if top==0 the stack is empty and
// if top==capacity it needs to be expanded before pushing another element.
// However for security there is still a super maximum capacity that cannot
// be exceeded.

#define MAX_CAPACITY 32768
#define INITIAL_CAPACITY 16

template <typename T>
class Stack {
  unique_ptr<T[]> elements;
  int capacity;
  int top;

  Stack(const Stack<T>&) = delete;
  Stack<T>& operator=(const Stack<T>&) = delete;

  
public:
  Stack(): top(0), capacity(INITIAL_CAPACITY), elements(make_unique<T[]>(INITIAL_CAPACITY)) {}
  
  int size() const {
    return top;
  }

  bool is_empty() const {
    return top == 0;
  }

  bool is_full() const {
    return top == MAX_CAPACITY; 
  }

  void push(T item) {
    if (is_full()) {
      throw overflow_error("Stack has reached maximum capacity");
    }
    if (top == capacity) {
      reallocate();
    }
    elements[top++] = item;
  }

  T pop() {
    if (is_empty()) {
      throw underflow_error("cannot pop from empty stack");
    }

    T top_element = elements[--top];
    elements[top] = T();

    if (top <= capacity / 4) {
      reallocate();
    }

    return top_element;
  }

private:

  void reallocate() {
    int updated_capacity = min(capacity * 2, MAX_CAPACITY);
    auto updated_elements = make_unique<T[]>(updated_capacity);
    copy(&elements[0], &elements[top], &updated_elements[0]);
    elements = std::move(updated_elements);
    capacity = updated_capacity;
  }
};

