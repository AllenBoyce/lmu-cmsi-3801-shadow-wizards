local Quaternion = {}
Quaternion.__index = Quaternion

function Quaternion.new(a, b,c,d)
    local self = setmetatable({}, Quaternion)
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    return self
end


function Quaternion:coefficients()
    return {self.a, self.b, self.c, self.d}
end

function Quaternion.__tostring(self)
    local string = ""
    local coefficients = self:coefficients()
    local variableLetters = {"","i","j","k"}
    for i = 1, 4 do
        if coefficients[i] ~= 0 then
            string = string .. tostring(coefficients[i]) .. variableLetters[i]
        end
        if i < 4 then
            if coefficients[i+1] > 0 then
                string = string .. "+"
            end
        end
    end
    if string == "" then
        return "0"
    end
    return string
end

function Quaternion.__add(q1, q2)
    return Quaternion.new(
        q1.a + q2.a,
        q1.b + q2.b,
        q1.c + q2.c,
        q1.d + q2.d
    )
end

function Quaternion.__mul(q1, q2)
    return Quaternion.new(
        q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
        q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
        q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b,
        q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
    )
end

function Quaternion:conjugate()
    return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

function Quaternion.__eq(q1, q2)
    local coeff1 = q1:coefficients()
    local coeff2 = q2:coefficients()
    for i = 1, 4 do
        if coeff1[i] ~= coeff2[i] then
            return false
        end
    end
    return true
end

q1 = Quaternion.new(2, 5, 0, 2)
q2 = Quaternion.new(-5, 3, 1, -3)

print(tostring(q1))
print(tostring(q1+q2))
print(tostring(q1*q2))
print(tostring(q1:conjugate()))
print(table.unpack(q1:coefficients()))
print(q1 == q2)
print(q1 == Quaternion.new(2,5,0,2))