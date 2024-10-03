import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// Write your first then lower case function here
func firstThenLowerCase(of array_of_strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return array_of_strings.first(where: predicate)?.lowercased()
}
// Write your say function here

struct Sayer {
    let phrase: String
    func and (_ word: String) -> Sayer {
        let newPhrase = phrase.isEmpty ? word : phrase + " " + word
        return Sayer(phrase: phrase + " " + word)
    }
}
func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}


// Write your meaningfulLineCount function here
func meaningfulLineCount(_ fileName: String) async -> Result<Int, Error> {
    var lineCount: Int = 0
    let fileURL:URL = URL(fileURLWithPath: fileName)
    do {
        for try await line: String in fileURL.lines{
            var trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if !trimmedLine.isEmpty {
                if trimmedLine[trimmedLine.startIndex] != "#" {
                    lineCount += 1
                }
            }
        }
    }
    catch {
        return .failure(NoSuchFileError())
    }
    return .success(lineCount)
}

// Write your Quaternion struct here

struct Quaternion: CustomStringConvertible, Equatable {
    let a, b, c, d: Double
    static let ZERO = Quaternion(a: 0,b: 0,c: 0,d: 0)
    static let ONE = Quaternion(a: 1,b: 0,c: 0,d: 0)
    static let I = Quaternion(a: 0,b: 1,c: 0,d: 0)
    static let J = Quaternion(a: 0,b: 0,c: 1,d: 0)
    static let K = Quaternion(a: 0,b: 0,c: 0,d: 1)

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a;
        self.b = b;
        self.c = c;
        self.d = d;
    }

    var coefficients: [Double] {
        return [a,b,c,d]
    }
    
    var conjugate: Quaternion {
        return Quaternion(a: a,b: -b,c: -c,d: -d)
    }

    static func +(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    static func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
            b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
            c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
            d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        )
    }

        var description: String {
        var retVal = ""
        let variableLetters = ["", "i", "j", "k"]
        let coefficients = self.coefficients

        for i in 0..<4 {
            // The first variable is an exception since it doesn't have a variable to it.
            // We just want to add its coefficient, so long as it isn't 0.
            if i == 0 && coefficients[0] != 0 {
                retVal += "\(coefficients[i])"
            } else {
                // If the coefficient is zero, skip this variable
                if coefficients[i] != 0 {
                    // If the coefficient is 1, we want to skip adding 1 to the string, UNLESS it's the first variable
                    if coefficients[i] != 1 {
                        // If the coefficient is negative 1, just add '-' instead of -1
                        if coefficients[i] == -1 {
                            retVal += "-"
                        }
                        // Otherwise, add the whole coefficient: sign and value.
                        else {
                            retVal += "\(coefficients[i])"
                        }
                    }
                    
                    // Add the variable letter after the coefficient.
                    retVal += variableLetters[i]
                }
            }

            // Add the plus according to the value of the next coefficient.
            // If this is the last coefficient, there'll be no plus.
            // If the string is empty, don't add the plus operator.
            if i < 3 && !retVal.isEmpty {
                if coefficients[i+1] > 0 {
                    retVal += "+"
                }
            }
        }
        // If the string is empty at this point, there's no value in the Quaternion, and it's equal to 0.
        if retVal.isEmpty {
            return "0"
        }
        return retVal
    
    }
}

// Write your Binary Search Tree enum here
