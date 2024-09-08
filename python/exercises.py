from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(list_of_strings: list[str], predicate):
    for string in list_of_strings:
        if predicate(string):
            return string.lower()
    return None

# Write your powers generator here
def powers_generator(base, limit):
    current_power = 0
    while base ** current_power <= limit:
        yield base ** current_power
        current_power+=1

# Write your say function here

# Write your line count function here

# Write your Quaternion class here
