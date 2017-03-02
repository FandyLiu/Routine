//: Playground - noun: a place where people can play

import UIKit


func printCharacters(in set: CharacterSet) {
    var characters = ""
    let iSet = set.inverted
    for i: UInt32 in 32..<127 {
        let c = UnicodeScalar(i)!
        if iSet.contains(c) {
            characters += String(c)
        }
    }
    print("'\(characters)'")
}


let b = CharacterSet.urlPathAllowed

printCharacters(in: b)







