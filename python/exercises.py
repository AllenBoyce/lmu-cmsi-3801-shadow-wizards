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


    def __str__(self):
        stringVer = ""
        coefTypes=["", "i", "j", "k"]
        for i in range(len(self.coefficients)):
            if(not self.coefficients[i] == 0):
                if(self.coefficients[i] == 1):
                    stringVer += "%s" % (coefTypes[i])
                else:
                    stringVer += "%s%s" % (self.coefficients[i], coefTypes[i])
            if(i < len(self.coefficients)-1):
                if(self.coefficients[i+1] > 0):
                    stringVer += "+"
        if stringVer == "":
            return "0"
        return stringVer
    
    def __add__(self, addend):
        return Quaternion(self.a + addend.a, self.b + addend.b, self.c + addend.c, self.d + addend.d)
    
    def __mul__(self, factor):
        
        p = self.a*factor.a - self.b*factor.b - self.c*factor.c - self.d*factor.d
        i = self.a*factor.b + self.b*factor.a + self.c*factor.d - self.d*factor.c
        j = self.a*factor.c - self.b*factor.d + self.c*factor.a + self.d*factor.b
        k = self.a*factor.d + self.b*factor.c - self.c*factor.b + self.d*factor.a
        
        return Quaternion(p, i, j, k)
    
    def __eq__(self, other):
        return self.coefficients == other.coefficients
    
    @property
    def conjugate(self):
        return Quaternion(self.coefficients[0], -self.coefficients[1], -self.coefficients[2], -self.coefficients[3])
    
    @property
    def coefficients(self):
        return [self.a, self.b, self.c, self.d]