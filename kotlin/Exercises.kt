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

// Write your meaningfulLineCount function here

// Write your Quaternion data class here
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    companion object {
        val ZERO = Quaternion(0.0,0.0,0.0,0.0)
        val ONE = Quaternion(1.0,0.0,0.0,0.0)
        val I = Quaternion(0.0,1.0,0.0,0,0)
        val J = Quaternion(0.0,0.0,1.0,0.0)
        val K = Quaternion(0.0,0.0,0.0,1.0)
    }

    operator fun plus(other: Quaternion) {
        return Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)
    }

    operator fun times(other: Quaternion) {
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d,
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        )
    }

    fun coefficients(): List<Double> = return listOf(a, b, c, d)

    fun conjugate(): Quaternion = return Quaternion(a, -b, c, -d)
}
// Write your Binary Search Tree interface and implementing classes here
