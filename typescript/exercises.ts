import { open } from "node:fs/promises"

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then apply function here

export function firstThenApply<T, U>(items: T[], predicate: (item: T) => boolean, consumer: (item: T) => U): U | undefined {
  let potentialCandidate: any | undefined = items.find(predicate) 
  if (potentialCandidate != undefined){
    return consumer(potentialCandidate)
  }
  return undefined
}

// Write your powers generator here

// Write your line count function here
export async function meaningfulLineCount(fileName: string) {
  let lineCount: number = 0
  const fileToCheck = await open(fileName, "r")
  for await (const line of fileToCheck.readLines()) {
    if(line.trim() !== ""){
      if(line.trim()[0] !== "#"){
        lineCount++
      }
    }
  }
  return lineCount
}

// Write your shape type and associated functions here

// Write your binary search tree implementation here
