import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

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

// Write your first then lower case function here
fun firstThenLowerCase(listOfStrings: List<String>, predicateToCheck: (String) -> Boolean): String? {
    return listOfStrings.firstOrNull{ predicateToCheck }?.lowercase()
}
// Write your say function here

data class Say(val phrase: String) {
    fun and (nextPhrase: String): Say {
        return Say("$phrase $nextPhrase")
    }
}
fun say(phrase: String = ""): Say {
    return Say(phrase)
}

// Write your meaningfulLineCount function here

// Write your Quaternion data class here
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
            // The first variable is an exception since it doesn't have a variable to it.
            // We just want to add its coefficient, so long as it isn't 0.
            if (i == 0 && coefficients[0] != 0.0) {
                retVal += coefficients[i]
            } else {
                // If the coefficient is zero, skip this variable
                if (coefficients[i] != 0.0) {
                    // If the coefficient is 1, we want to skip adding 1 to the string, UNLESS it's the first variable
                    if (coefficients[i] != 1.0) {
                        // If the coefficient is negative 1, just add '-' instead of -1
                        if (coefficients[i] == -1.0) {
                            retVal += "-"
                        }
                        // Otherwise, add the whole coefficient: sign and value.
                        else {
                            retVal += coefficients[i]
                        }
                    }

                    // Add the variable letter after the coefficient.
                    retVal += variableLetters[i]
                }
            }

            // Add the plus according to the value of the next coefficient.
            // If this is the last coefficient, there'll be no plus.
            // If the string is empty, don't add the plus operator.
            if (i < 3 && retVal.isNotEmpty()) {
                if (coefficients[i+1] > 0) {
                    retVal += "+"
                }
            }
    }
    // If the string is empty at this point, there's no value in the Quaternion, and it's equal to 0.
    if (retVal.isEmpty()) {
        return "0"
    }
    return retVal
}

// Write your Binary Search Tree interface and implementing classes here
