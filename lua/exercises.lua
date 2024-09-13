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
