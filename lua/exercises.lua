-- Had to change a few lines to get the program working with my version of Lua 
function change(amount)
  if math.floor(amount) ~= amount then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = math.floor(remaining / denomination)
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(table_of_strings, predicate)
  if table_of_strings == {} then
      return nil
  end
  for _, item in ipairs(table_of_strings) do
    if predicate(item) then
      return string.lower(item)
    end
  end
  return nil
end
-- Write your powers generator here

--Generates a series of exponents with the same base and an incrementing power, until the exponents value surpasses a given limit
function powers_generator(ofBase, upTo)
  return coroutine.create(function()
    --The power starts at 0.
    local currentPower = 0
    while ofBase ^ currentPower <= upTo do
      --Yield the current exponent value
      coroutine.yield(ofBase ^ currentPower)
      --Increment the power
      currentPower = currentPower + 1
    end
  end)
end

-- Write your say function here
function say(word)
  if word == nil then
    return ""
  end
  
  local function chain(next)
    if next == nil then
      return word
    else
      return say(word .. " " .. next)
    end
  end
  return chain
end

-- Write your line count function here
  function meaningful_line_count(file_name)
    local line_count = 0
    local file_to_check = io.open(file_name, 'r')
    if file_to_check then
      for line in file_to_check:lines() do
        if line:gsub('%s+', '') == '' then
        elseif string.sub(line:gsub ('%s+', ''), 1, 1) == '#' then
        else 
          line_count = line_count + 1
        end
      end
    else
      error("No such file")
    end
    return line_count
  end

-- Write your Quaternion table here
Quaternion = {}
Quaternion.__index = Quaternion

--Constructor that takes in coefficients
function Quaternion.new(a, b,c,d)
  local self = setmetatable({}, Quaternion)
  self.a = a
  self.b = b
  self.c = c
  self.d = d
  return self
end

--Returns a table consisting of this Quaternion's coefficients
function Quaternion:coefficients()
  return {self.a, self.b, self.c, self.d}
end

--Returns the string value of the Quaternion.
--String is represented as an equation consisting of the sum of all the Quaternion's parts
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

--Returns a new Quaternion that represents the sum of the two Quaternions added.
function Quaternion.__add(q1, q2)
  return Quaternion.new(
      q1.a + q2.a,
      q1.b + q2.b,
      q1.c + q2.c,
      q1.d + q2.d
  )
end

--Returns a new Quaternion that represents the product of the two Quaternions multiplied.
function Quaternion.__mul(q1, q2)
  return Quaternion.new(
      q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
      q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
      q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b,
      q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
  )
end

--Returns a new Quaternion that represents the conjugate of this Quaternion
function Quaternion:conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

--Returns whether or not the two Quaternions have equal coefficient values.
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