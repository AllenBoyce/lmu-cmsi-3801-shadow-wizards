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

-- Write your say function here

-- Write your line count function here

-- Write your Quaternion table here
