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
def first_then_lower_case(list_of_strings: list[str], predicate: Callable):
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
def meaningful_line_count(file_name: str) -> int:
    line_count: int = 0
    with open(file_name, 'r', encoding="utf8") as file_to_check:
        for line in file_to_check:
            if line.strip() == "":
                continue
            elif line.strip()[0] == "#":
                continue
            else:
                line_count += 1
    return line_count

# Write your Quaternion class here
