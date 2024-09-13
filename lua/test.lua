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

    --The variables that correspond to each part of the Quaternion. The first element is an empty string because there is no variable.
    local variableLetters = {"","i","j","k"}

    for i = 1, 4 do

        --The first variable is an exception since it doesn't have a variable to it.
        --We just want to add its coefficient, so long as it isn't 0.
        if i == 1 and coefficients[1] ~= 0 then
            string = string .. coefficients[i]
        else
        
            --If the coefficient is zero, skip this variable
            if coefficients[i] ~= 0 then

                --If the coefficient is 1, we want to skip adding 1 to the string, UNLESS it's the first variable
                
                if coefficients[i] ~= 1 then

                    --If the coefficient is negative 1, just add '-' instead of -1
                    if coefficients[i] == -1 then
                        string = string .. "-"
                    --Otherwise, add the whole coefficient: sign and value.
                    else
                        string = string .. tostring(coefficients[i]) 
                    end
                end
                --Add the variable letter after the coefficient.
                string = string .. variableLetters[i]
            end

        --Add the plus according to the value of the next coefficient.
        --If this is the last coefficient, there'll be no plus.
        -- If the string is empty, don't add the plus operator.
        if i < 4 and string ~="" then
            if coefficients[i+1] > 0 then
                string = string .. "+"
            end
        end
    end
    end
    --If the string is empty at this point, there's no value in the Quaternion, and it's equal to 0.
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

q = Quaternion.new(3.5, 2.25, -100.0, -1.25)
-- print(q.a == 3.5)
-- print(q.b == 2.25)
-- print(q.c == -100.0)
-- print(q.d == -1.25)
q1 = Quaternion.new(1.0, 3.0, 5.0, 2.0);
q2 = Quaternion.new(-2.0, 2.0, 8.0, -1.0);
q3 = Quaternion.new(-1.0, 5.0, 13.0, 1.0);
q4 = Quaternion.new(-46.0, -25.0, 5.0, 9.0);
zero = Quaternion.new(0, 0, 0, 0)
i = Quaternion.new(0, 1, 0, 0)
j = Quaternion.new(0, 0, 1, 0)
k = Quaternion.new(0, 0, 0, 1)
-- print(q1 + q2 == q3)
-- print(q1 * q2 == q4)
-- print(q1 + zero == q1)
-- print(q1 * zero == zero)
-- print(i * j == k)
-- print(j * k == i)
-- print(j + i == Quaternion.new(0.0, 1.0, 1.0, 0.0))
print(tostring(zero))
print(tostring(zero) == "0")
print(tostring(j))
print(tostring(j) == "j")
print(tostring(k:conjugate()))
print(tostring(k:conjugate()) == "-k")
print(tostring(j:conjugate() * Quaternion.new(2.0, 0.0, 0.0, 0.0)))
print(tostring(j:conjugate() * Quaternion.new(2.0, 0.0, 0.0, 0.0)) == "-2.0j")
print(tostring(j + k))
print(tostring(j + k) == "j+k")
print(tostring(Quaternion.new(0.0, -1.0, 0.0, 2.25)))
print(tostring(Quaternion.new(0.0, -1.0, 0.0, 2.25)) == "-i+2.25k")
-- -- print(tostring(Quaternion.new(-20.0, -1.75, 13.0, -2.25)) == "-20.0-1.75i+13.0j-2.25k")
-- -- print(tostring(Quaternion.new(-1.0, -2.0, 0.0, 0.0)) == "-1.0-2.0i")
-- -- print(tostring(Quaternion.new(1.0, 0.0, -2.0, 5.0)) == "1.0-2.0j+5.0k")