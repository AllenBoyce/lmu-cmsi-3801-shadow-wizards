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

export function firstThenApply<T, U>(
  items: T[],
  predicate: (item: T) => boolean,
  consumer: (item: T) => U
): U | undefined {
  let potentialCandidate: any | undefined = items.find(predicate)
  if (potentialCandidate != undefined) {
    return consumer(potentialCandidate)
  }
  return undefined
}

export function* powersGenerator(base: bigint): Generator<bigint> {
  let exponent = 0n
  while (true) {
    yield base ** exponent
    exponent += 1n
  }
}

export async function meaningfulLineCount(fileName: string) {
  let lineCount: number = 0
  const fileToCheck = await open(fileName, "r")
  for await (const line of fileToCheck.readLines()) {
    if (line.trim() !== "") {
      if (line.trim()[0] !== "#") {
        lineCount++
      }
    }
  }
  return lineCount
}

export type Shape = Sphere | Box

interface Sphere {
  kind: "Sphere"
  radius: number
}

interface Box {
  kind: "Box"
  width: number
  length: number
  depth: number
}

export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return 4 * Math.PI * shape.radius ** 2
    case "Box":
      return (
        (shape.width * shape.length +
          shape.length * shape.depth +
          shape.width * shape.depth) *
        2
      )
  }
}
export function volume(shape: Shape): number {
  switch (shape.kind) {
    case "Sphere":
      return (4 / 3) * Math.PI * shape.radius ** 3
    case "Box":
      return shape.width * shape.length * shape.depth
  }
}

export interface BinarySearchTree<T> {
  size(): number
  insert(value: T): BinarySearchTree<T>
  contains(value: T): boolean
  inorder(): Iterable<T>
}
export class Empty<T> implements BinarySearchTree<T> {
  size(): number {
    return 0
  }

  insert(value: T): BinarySearchTree<T> {
    return new Node(value, new Empty(), new Empty())
  }

  contains(value: T): boolean {
    return false
  }

  *inorder(): Iterable<T> {
    yield* []
  }

  toString(): string {
    return "()"
  }
}

class Node<T> implements BinarySearchTree<T> {
  constructor(
    private value: T,
    private left: BinarySearchTree<T>,
    private right: BinarySearchTree<T>
  ) {}

  size(): number {
    return 1 + this.left.size() + this.right.size()
  }

  insert(value: T): BinarySearchTree<T> {
    if (value < this.value) {
      return new Node(this.value, this.left.insert(value), this.right)
    } else if (value > this.value) {
      return new Node(this.value, this.left, this.right.insert(value))
    } else {
      // Value already exists, return unchanged tree
      return this
    }
  }

  contains(value: T): boolean {
    if (value === this.value) {
      return true
    } else if (value < this.value) {
      return this.left.contains(value)
    } else {
      return this.right.contains(value)
    }
  }

  *inorder(): Iterable<T> {
    yield* this.left.inorder()
    yield this.value
    yield* this.right.inorder()
  }

  toString(): string {
    let returnVal = "("
    if (this.left.size() !== 0) {
      returnVal += this.left.toString()
    }
    returnVal += this.value
    if (this.right.size() !== 0) {
      returnVal += this.right.toString()
    }
    returnVal += ")"
    return returnVal
  }
}
