from dataclasses import dataclass


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


q1 = Quaternion(2, 5, 0, 2)
q2 = Quaternion(-5, 3, 1, -3)

print(q1)
print(q2)
print(q1 + q2)
print(q1*q2)
print(q1.conjugate)
print(q1.coefficients)
print(q1 == q2)
print(q1 == Quaternion(2, 5, 0, 2))
q1.a
q1.a = 5