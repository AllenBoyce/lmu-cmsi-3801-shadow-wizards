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

    // Write your Quaternion record class here
    public static class Quaternion {
        private double a;
        private double b;
        private double c;
        private double d;

        public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
        public static final Quaternion I = new Quaternion(0, 1, 0, 0);
        public static final Quaternion J = new Quaternion(0, 0, 1, 0);
        public static final Quaternion K = new Quaternion(0, 0, 0, 1);


        public Quaternion(double a, double b, double c, double d) {

            if(a == Double.NaN || b  == Double.NaN || c  == Double.NaN || d == Double.NaN) {
                throw new IllegalArgumentException("Coefficients cannot be NaN");
            }

            this.a = a;
            this.b = b;
            this.c = c;
            this.d = d;
        }

        public ArrayList<Double> coefficients() {
            ArrayList<Double> coefs = new ArrayList<Double>();

            coefs.add(a);
            coefs.add(b);
            coefs.add(c);
            coefs.add(d);

            return coefs;
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

        public Quaternion times(Object other) {
            if (other instanceof Quaternion) {
                Quaternion q = (Quaternion) other;
                return new Quaternion(
                    a * q.a - b * q.b - c * q.c - d * q.d,
                    a * q.b + b * q.a + c * q.d - d * q.c,
                    a * q.c - b * q.d + c * q.a + d * q.b,
                    a * q.d + b * q.c - c * q.b + d * q.a
                );
            } else {
                throw new IllegalArgumentException("Given object is not a Quaternion");
            }
        }

        public Quaternion plus(Object other) {
            if(!(other instanceof Quaternion)) {
                throw new Error("Given object is not a Quaternion");
            }
            Quaternion otherQuaternion = (Quaternion) other;
            ArrayList<Double> otherCoefs = otherQuaternion.coefficients();
            return new Quaternion(a + otherCoefs.get(0), b + otherCoefs.get(1), c + otherCoefs.get(2), d + otherCoefs.get(3));
        }

        @Override
        public boolean equals(Object other) {
            if(!(other instanceof Quaternion)) {
                return false;
            }
            ArrayList<Double> otherCoefs = ((Quaternion) other).coefficients();
            ArrayList<Double> coefficients = this.coefficients();
            return otherCoefs.equals(coefficients);
        }

        @Override
        public String toString() {
            String retVal = "";
            String[] variableLetters = {"", "i", "j", "k"};
            ArrayList<Double> coefficients = this.coefficients();

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

}

// Write your BinarySearchTree sealed interface and its implementations here
