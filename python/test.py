from dataclasses import dataclass
@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float


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
        return (self.a, self.b, self.c, self.d)
q1 = Quaternion(1.0, 3.0, 5.0, 2.0)
q2 = Quaternion(-2.0, 2.0, 8.0, -1.0)
q3 = Quaternion(-1.0, 5.0, 13.0, 1.0)
q4 = Quaternion(-46.0, -25.0, 5.0, 9.0)

zero = Quaternion(0, 0, 0, 0)
i = Quaternion(0, 1, 0, 0)
j = Quaternion(0, 0, 1, 0)
k = Quaternion(0, 0, 0, 1)

print(zero.coefficients)
print(k.coefficients)
print(q2.coefficients)
print(q4.conjugate)

print(zero.coefficients == (0.0, 0.0, 0.0, 0.0))
print(k.coefficients == (0.0, 0.0, 0.0, 1.0))
print(q2.coefficients == (-2.0, 2.0, 8.0, -1.0))
print(q4.conjugate == Quaternion(-46.0, 25.0, -5.0, -9.0))