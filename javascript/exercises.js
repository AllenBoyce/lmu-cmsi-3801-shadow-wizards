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
export function say(word) {
  if (word === undefined) {
    return "";
  }
//if there is no string or it is blank it'll return nothing
  function chain(next) {
    if (next === undefined) {
      return word;
    } else {
    //if there is no word next then it'll go back and reprint the previous words
      return say(word + " " + next);
    }
    //this joins the different words to make them 'whole'
  }

  return chain;
}

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
export class Quaternion {
  constructor(a, b, c, d) {
    this.a = a
    this.b = b
    this.c = c
    this.d = d
    Object.freeze(this)
  }

  plus(q) {
    return new Quaternion(
      this.a + q.a,
      this.b + q.b,
      this.c + q.c,
      this.d + q.d
    )
  }

  times(q) {
    return new Quaternion(
      this.a * q.a - this.b * q.b - this.c * q.c - this.d * q.d,
      this.a * q.b + this.b * q.a + this.c * q.d - this.d * q.c,
      this.a * q.c - this.b * q.d + this.c * q.a + this.d * q.b,
      this.a * q.d + this.b * q.c - this.c * q.b + this.d * q.a
    )
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d)
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d]
  }

  toString() {
    //List with the different variables used in each part of the Quaternion
    const coefficientTypes = ["", "i", "j", "k"]
    let quaternionString = ""

    //Run this loop 4 times, one for each coefficient in the Quaternion
    for (let i = 0; i < 4; i++) {
      //curentCoefficient is whichever coefficient value the loop is currently adding to the string
      const currentCoefficient = this.coefficients[i]

      //Skip if the coefficient is 0.
      if (currentCoefficient !== 0) {
        //If the string isn't empty and the current coefficient is positive
        //We add the plus sign before we add the coefficient value
        if (quaternionString !== "" && currentCoefficient > 0) {
          quaternionString += "+"
        }

        if (currentCoefficient === 1 && i !== 0) {
          //If the current coefficient is 1 and it isn't the first coefficient,
          //Then we only add the variable letter
          quaternionString += coefficientTypes[i]
        } else if (currentCoefficient === -1 && i !== 0) {
          //If the current coefficient is -1 and it isn't the first coefficient,
          //Then we only add the minus sign and the variable letter.
          quaternionString += `-${coefficientTypes[i]}`
        } else {
          //Otherwise, we're good to just add the current coefficient and the current coefficient type.
          quaternionString += `${currentCoefficient}${coefficientTypes[i]}`
        }
      }
    }
    //If the string is empty, all the coefficients are 0. So return 0.
    if (quaternionString == "") {
      return "0"
    }
    return quaternionString
  }

  equals(q) {
    if (!(q instanceof Quaternion)) {
      return false
    }
    return this.a === q.a && this.b === q.b && this.c === q.c && this.d === q.d
  }
}
