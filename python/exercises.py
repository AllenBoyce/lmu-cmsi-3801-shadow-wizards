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

# Generates a series of exponents with the same base and an incrementing power, until the exponents value surpasses a given limit
def powers_generator(base, limit):
    #The power starts at 0
    current_power = 0
    while base ** current_power <= limit:
        #Yield base to the power of the current power
        yield base ** current_power
        #Increment current power
        current_power+=1

# Write your say function here
def say(word=None):
    words = [] 
    if word is not None:
        words.append(word)

    if word is None:
        return ""

    def chain (next_word=None):
        nonlocal words
        if next_word is None:
            return " ".join(words)
        else:
            words.append(next_word)      
            return chain
    return chain

# Write your line count function here
def meaningful_line_count(file_name: str) -> int:
    line_count: int = 0
    try:
        with open(file_name, 'r', encoding="utf8") as file_to_check:
            for line in file_to_check:
                if line.strip() == "":
                    continue
                elif line.strip()[0] == "#":
                    continue
                else:
                    line_count += 1
    except:
        raise FileNotFoundError ("No such file")
    return line_count

# Write your Quaternion class here
@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float


    # Returns the string value of the Quaternion.
    # String is represented as an equation consisting of the sum of all the Quaternion's parts
    def __str__(self):
        string = ""
        coefficients = self.coefficients

        # The variables that correspond to each part of the Quaternion. 
        # The first element is an empty string because there is no variable.
        variable_letters = ["", "i", "j", "k"]

        for i in range(4):
            # The first variable is an exception since it doesn't have a variable to it.
            # We just want to add its coefficient, so long as it isn't 0.
            if i == 0 and coefficients[0] != 0:
                string += str(coefficients[i])
            else:
                # If the coefficient is zero, skip this variable
                if coefficients[i] != 0:
                    # If the coefficient is 1, we want to skip adding 1 to the string, UNLESS it's the first variable
                    if coefficients[i] != 1:
                        # If the coefficient is negative 1, just add '-' instead of -1
                        if coefficients[i] == -1:
                            string += "-"
                        # Otherwise, add the whole coefficient: sign and value.
                        else:
                            string += str(coefficients[i])
                    
                    # Add the variable letter after the coefficient.
                    string += variable_letters[i]

            # Add the plus according to the value of the next coefficient.
            # If this is the last coefficient, there'll be no plus.
            # If the string is empty, don't add the plus operator.
            if i < 3 and string != "":
                if coefficients[i+1] > 0:
                    string += "+"

        # If the string is empty at this point, there's no value in the Quaternion, and it's equal to 0.
        if string == "":
            return "0"
        return string
    
    # Returns a Quaternion representing the sum of this Quaternion and the given addend
    def __add__(self, addend):
        return Quaternion(self.a + addend.a, self.b + addend.b, self.c + addend.c, self.d + addend.d)
    
    # Returns a Quaternion representing the product of this Quaternion and the given factor
    def __mul__(self, factor):
        
        p = self.a*factor.a - self.b*factor.b - self.c*factor.c - self.d*factor.d
        i = self.a*factor.b + self.b*factor.a + self.c*factor.d - self.d*factor.c
        j = self.a*factor.c - self.b*factor.d + self.c*factor.a + self.d*factor.b
        k = self.a*factor.d + self.b*factor.c - self.c*factor.b + self.d*factor.a
        
        return Quaternion(p, i, j, k)
    
    #returns whether or not this Quaternion has equivalent coefficients as the given Quaternion.
    def __eq__(self, other):
        return self.coefficients == other.coefficients
    
    #returns a Quaternion that represents the conjugate of this Quaternion
    @property
    def conjugate(self):
        return Quaternion(self.coefficients[0], -self.coefficients[1], -self.coefficients[2], -self.coefficients[3])
    
    #returns a tuple with the coefficients of the Quaternion
    @property
    def coefficients(self):
        return (self.a, self.b, self.c, self.d)