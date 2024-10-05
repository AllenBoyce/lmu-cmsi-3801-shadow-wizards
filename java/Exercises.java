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

    static Optional<String> firstThenLowerCase(List<String> listOfStrings, Predicate<String> predicateToCheck) {
        var streamOfStrings = listOfStrings.stream()
        .filter(predicateToCheck)
        .map(String::toLowerCase)
        .findFirst(); 
        return streamOfStrings;
    }
    
    static record Sayer(String phrase) {

        Sayer and(String word) {
            return new Sayer(phrase + " " + (word != null ? word : ""));
        }
    }
    
    public static Sayer say() {
        return new Sayer("");
    }
    
    public static Sayer say(String word) {
        return new Sayer(word != null ? word : "");
    }
    
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
        if (i == 0 && coefficients.get(0) != 0) {
            retVal += (coefficients.get(i));
        } else {
            if (coefficients.get(i) != 0) {
                if (coefficients.get(i) != 1) {
                    if (coefficients.get(i) == -1) {
                        retVal += ("-");
                    }
                    else {
                        retVal += (coefficients.get(i));
                    }
                }
                retVal += (variableLetters[i]);
            }
        }

        if (i < 3 && retVal.length() > 0 && coefficients.get(i+1) > 0) {
                retVal += ("+");
        }
    }
    if (retVal.length() == 0) {
        return "0";
    }
        return retVal;
    }
}


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
        if (val.compareTo(this.value) < 0) {
            return new Node(this.value, left.insert(val), right);
        } else if (val.compareTo(this.value) > 0) {
            return new Node(this.value, left, right.insert(val));
        } else {
            return this;
        }
    }

    @Override
    public String toString() {
        String returnVal = "(";
        if(left.size() != 0) {
            returnVal += left;
        }
        returnVal += value;
        if(right.size() != 0) {
            returnVal += right;
        }
        returnVal += ")";
        return returnVal;
    }
}