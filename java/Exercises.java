import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    // Write your first then lower case function here

    static Optional<String> firstThenLowerCase(List<String> listOfStrings, Predicate<String> predicateToCheck) {
        var streamOfStrings = listOfStrings.stream()
        .filter(predicateToCheck)
        .map(String::toLowerCase)
        .findFirst(); 
        return streamOfStrings;
    }

    // Write your say function here



        // Static record to hold the phrase and allow chaining
        static record Sayer(String phrase) {

            // Method to chain words (add words to the phrase)
            Sayer and(String word) {
                if (word != null && !word.isBlank()) {
                    // Concatenate the new word with the existing phrase, with a space in between if needed
                    return new Sayer(phrase.isBlank() ? word : phrase + " " + word);
                }
                return this;
            }
        }
        // Method to start the chain with an empty phrase
        public static Sayer say() {
            return new Sayer("");  // Starts with an empty string
        }
        // Method to start the chain with an initial word
        public static Sayer say(String word) {
            return new Sayer(word);  // Starts with the provided word
        }
    

    // Write your line count function here
    
    static long meaningfulLineCount(String fileName) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))){
            return reader.lines()
            .filter(line -> !line.trim().isEmpty())
            .filter(line -> !line.trim().startsWith("#"))
            .count();
        } catch (FileNotFoundException e) {
            throw new FileNotFoundException("No such file");
        }
    }
    

}

record Quaternion(double a, double b, double c, double d) {

    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K = new Quaternion(0, 0, 0, 1);


    public Quaternion {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    public double a() {
        return a;
    }
    public double b() {
        return b;
    }
    public double c() {
        return c;
    }
    public double d() {
        return d;
    }

    public Quaternion times(Quaternion other) {
            return new Quaternion(
                a * other.a - b * other.b - c * other.c - d * other.d,
                a * other.b + b * other.a + c * other.d - d * other.c,
                a * other.c - b * other.d + c * other.a + d * other.b,
                a * other.d + b * other.c - c * other.b + d * other.a
            );
        
    }

    public Quaternion plus(Quaternion other) {
        return new Quaternion(a + other.a, b + other.b, c + other.c, d + other.d);
    }

    public List<Double> coefficients() {
        return List.of(a,b,c,d);
    }

    public boolean equals(Quaternion other) {

        return coefficients().equals(other.coefficients());
    }

    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    public String toString() {
        String retVal = "";
        String[] variableLetters = {"", "i", "j", "k"};
        ArrayList<Double> coefficients = new ArrayList<Double>(coefficients());

    for (int i = 0; i < 4; i++) {
        // The first variable is an exception since it doesn't have a variable to it.
        // We just want to add its coefficient, so long as it isn't 0.
        if (i == 0 && coefficients.get(0) != 0) {
            retVal += (coefficients.get(i));
        } else {
            // If the coefficient is zero, skip this variable
            if (coefficients.get(i) != 0) {
                // If the coefficient is 1, we want to skip adding 1 to the string, UNLESS it's the first variable
                if (coefficients.get(i) != 1) {
                    // If the coefficient is negative 1, just add '-' instead of -1
                    if (coefficients.get(i) == -1) {
                        retVal += ("-");
                    }
                    // Otherwise, add the whole coefficient: sign and value.
                    else {
                        retVal += (coefficients.get(i));
                    }
                }
                
                // Add the variable letter after the coefficient.
                retVal += (variableLetters[i]);
            }
        }

        // Add the plus according to the value of the next coefficient.
        // If this is the last coefficient, there'll be no plus.
        // If the string is empty, don't add the plus operator.
        if (i < 3 && retVal.length() > 0) {
            if (coefficients.get(i+1) > 0) {
                retVal += ("+");
            }
        }
    }
    // If the string is empty at this point, there's no value in the Quaternion, and it's equal to 0.
    if (retVal.length() == 0) {
        return "0";
    }
        return retVal;
    }
}

// Write your BinarySearchTree sealed interface and its implementations here
sealed interface BinarySearchTree permits Empty, Node {
    int size();
    boolean contains(String value);
    BinarySearchTree insert(String value);
}

final record Empty() implements BinarySearchTree {
    @Override
    public int size() {
        return 0;
    }

    public boolean contains(String value) {
        return false;
    }

    @Override
    public BinarySearchTree insert(String value) {
        return new Node(value, this, this);
    }

    @Override
    public String toString() {
        return("()");
    }
    
}

final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    @Override
    public int size() {
        return 1 + left.size() + right.size();
    }

    @Override
    public boolean contains(String val) {
        return(this.value.equals(val) || left.contains(val) || right.contains(val));
    }

    @Override
    public BinarySearchTree insert(String val) {
        if(value.compareTo(this.value) < 0) {
            return new Node(this.value, left.insert(val), right);
        }
        else {
            return new Node(this.value, left, right.insert(val));
        }
    }

    @Override
    public String toString() {
        return "(" + left + value + right + ")";
    }
}