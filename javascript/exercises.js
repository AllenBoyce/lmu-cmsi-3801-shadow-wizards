import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(arrayOfStrings, predicate) {
  const check = arrayOfStrings.find(predicate)
  return check?.toLowerCase()
}
// Write your powers generator here
export function* powersGenerator({ ofBase, upTo }) {
  let currentPower = 0
  while (Math.pow(ofBase, currentPower) <= upTo) {
    yield Math.pow(ofBase, currentPower)
    currentPower++
  }
}

// Write your say function here

// Write your line count function here
export async function meaningfulLineCount(fileName) {
  let lineCount = 0
  const fileToCheck = await open(fileName, "r")
  for await (const line of fileToCheck.readLines()) {
    if (line.trim() === "") {
      continue
    } else if (line.trim()[0] === "#") {
      continue
    } else {
      lineCount++
    }
  }
  return lineCount
}

// Write your Quaternion class here
