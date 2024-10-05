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

func firstThenLowerCase(of array_of_strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return array_of_strings.first(where: predicate)?.lowercased()
}

struct Sayer {
    let phrase: String
    
    func and(_ word: String) -> Sayer {
        let newPhrase: String
        
        if phrase.isEmpty {
            newPhrase = word.isEmpty ? " " : word
        } else {
            newPhrase = phrase + (word.isEmpty ? " " : " ") + word
        }
        
        return Sayer(phrase: newPhrase)
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}

func meaningfulLineCount(_ fileName: String) async -> Result<Int, Error> {
    var lineCount: Int = 0
    let fileURL:URL = URL(fileURLWithPath: fileName)
    do {
        for try await line: String in fileURL.lines{
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
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
            if i == 0 && coefficients[0] != 0 {
                retVal += "\(coefficients[i])"
            } else {
                if coefficients[i] != 0 {
                    if coefficients[i] != 1 {
                        if coefficients[i] == -1 {
                            retVal += "-"
                        }
                        else {
                            retVal += "\(coefficients[i])"
                        }
                    }
                    retVal += variableLetters[i]
                }
            }
            if i < 3 && !retVal.isEmpty && coefficients[i+1] > 0{ 
                    retVal += "+"
            }
        }
        if retVal.isEmpty {
            return "0"
        }
        return retVal
    
    }
}

indirect enum BinarySearchTree {
    case empty
    case node(value: String, left: BinarySearchTree, right: BinarySearchTree)
    
    var size: Int {
        switch self {
        case .empty:
            return 0
        case .node(_, let left, let right):
            return 1 + left.size + right.size
        }
    }
    
    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case .node(let nodeValue, let left, let right):
            return nodeValue == value || left.contains(value) || right.contains(value)
        }
    }
    
    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(value: value, left: .empty, right: .empty)
        case .node(let nodeValue, let left, let right):
            if value < nodeValue {
                return .node(value: nodeValue, left: left.insert(value), right: right)
            } else if value > nodeValue {
                return .node(value: nodeValue, left: left, right: right.insert(value))
            } else {
                return self
            }
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty:
            return "()"
        case .node(let value, let left, let right):
            var result = "("
            if case .node = left {
                result += left.description
            }
            result += value
            if case .node = right {
                result += right.description
            }
            result += ")"
            return result
        }
    }
}
