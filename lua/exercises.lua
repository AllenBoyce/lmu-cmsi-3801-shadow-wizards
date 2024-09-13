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
function powers_generator(ofBase, upTo)
  return coroutine.create(function()
    local currentPower = 0
    while ofBase ^ currentPower <= upTo do
      coroutine.yield(ofBase ^ currentPower)
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