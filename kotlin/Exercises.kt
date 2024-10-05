import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException
import java.io.File

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}


fun firstThenLowerCase(listOfStrings: List<String>, predicateToCheck: (String) -> Boolean): String? {
    return listOfStrings.firstOrNull(predicateToCheck)?.lowercase()
}


data class Say(val phrase: String) {
    fun and (nextPhrase: String): Say {
        return Say("$phrase $nextPhrase")
    }
}
fun say(phrase: String = ""): Say {
    return Say(phrase)
}

fun meaningfulLineCount(fileName: String): Long {
    var lineCount: Long = 0;
    try {
        val file: File = File(fileName)
        file.bufferedReader().use { reader -> 
        reader.forEachLine { line ->
            var trimmedLine = line.trim()
            if (trimmedLine.isEmpty() == false) {
                if (trimmedLine.first() != '#') {
                    lineCount++
                }
            }
            }
        }
    }
    catch(e: IOException) {
        throw IOException("No such file", e)
    }
    return lineCount
}

data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    companion object {
        val ZERO = Quaternion(0.0,0.0,0.0,0.0)
        val ONE = Quaternion(1.0,0.0,0.0,0.0)
        val I = Quaternion(0.0,1.0,0.0,0.0)
        val J = Quaternion(0.0,0.0,1.0,0.0)
        val K = Quaternion(0.0,0.0,0.0,1.0)
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)
    }

    operator fun times(other: Quaternion): Quaternion {
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        )
    }

    fun coefficients(): List<Double> {
        return listOf(a, b, c, d)
    }

    fun conjugate(): Quaternion {
        return Quaternion(a, -b, -c, -d)
    }
    override fun toString(): String {
        var retVal = ""
        val variableLetters = arrayOf("", "i", "j", "k")
        val coefficients = ArrayList(coefficients())

        for (i in 0 until 4) {
            if (i == 0 && coefficients[0] != 0.0) {
                retVal += coefficients[i]
            } else {
                if (coefficients[i] != 0.0) {
                    if (coefficients[i] != 1.0) {
                        if (coefficients[i] == -1.0) {
                            retVal += "-"
                        }
                        else {
                            retVal += coefficients[i]
                        }
                    }
                    retVal += variableLetters[i]
                }
            }
            if (i < 3 && retVal.isNotEmpty() && coefficients[i+1] > 0) {
                retVal += "+"
            }
        }
        if (retVal.isEmpty()) {
            return "0"
        }
        return retVal
    }
}

sealed interface BinarySearchTree {
    fun size(): Int
    fun contains(value: String): Boolean
    fun insert(value: String): BinarySearchTree

object Empty : BinarySearchTree {
    override fun size(): Int = 0
    override fun contains(value: String): Boolean = false
    override fun insert(value: String): BinarySearchTree = Node(value, this, this)
    override fun toString(): String = "()"
}

data class Node(
    val value: String,
    val left: BinarySearchTree = BinarySearchTree.Empty,
    val right: BinarySearchTree = BinarySearchTree.Empty
) : BinarySearchTree {

        override fun size(): Int = 1 + left.size() + right.size()

        override fun contains(value: String): Boolean =
            when {
                this.value == value -> true
                value < this.value -> left.contains(value)
                else -> right.contains(value)
            }

        override fun insert(value: String): BinarySearchTree =
            when {
                value < this.value -> Node(this.value, left.insert(value), right)
                value > this.value -> Node(this.value, left, right.insert(value))
                else -> this
            }

        override fun toString(): String {
            var returnVal = "("
            if (left.size() != 0) {
                returnVal += left.toString()
            }
            returnVal += value
            if (right.size() != 0) {
                returnVal += right.toString()
            }
            returnVal += ")"
            return returnVal
        }
    }
}