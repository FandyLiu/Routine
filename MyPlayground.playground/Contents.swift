

import UIKit

struct Person {
    var name: String
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}


Person(name: "Lisa") == Person(name: "Lisa") // → true
Person(name: "Lisa") == Person(name: "Bart") // → false

print("aaa")