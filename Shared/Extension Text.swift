//
//  Extension Text.swift
//  Articles
//
//  Created by Jan Hovland on 24/02/2022.
//

import SwiftUI

func attributedString(_ str: String) -> AttributedString {
    var string = AttributedString()
    var string1 = AttributedString()
    var strArray = [String]()
    let count = str.count
    var value = ""
    
    for i in 0..<count {
        let t = str[i]
        if t == "." ||
            t == " " ||
            t == "=" ||
            t == "[" ||
            t == "]" ||
            t == "(" ||
            t == "\n" ||
            t == "/" ||
            t == "$" ||
            t == ")" {
            if value.count > 0 {
                strArray.append(value)
                value = ""
            }
            strArray.append(String(t))
        } else {
            value.append(String(t))
        }
    }
    
    let teller = strArray.count
    for i in 0..<teller {
        string1 = AttributedString(strArray[i])
        if string1 == "font" {
            string1.foregroundColor = Color(.yellow)
        }
        if string1 == "Font" {
            string1.foregroundColor = Color(.green)
        }
        if string1 == "foregroundColor" {
            string1.foregroundColor = Color(.red)
        }
        if string1 == "func" {
            string1.foregroundColor = Color(.blue)
        }
        string = string + string1
    }

    return string
}

extension String {

  //Allow string[Int] subscripting
  subscript(index: Int) -> Character {
    return self[self.index(self.startIndex, offsetBy: index)]
  }

  //Allow open ranges like `string[0..<n]`
  subscript(range: Range<Int>) -> Substring {
    let start = self.index(self.startIndex, offsetBy: range.lowerBound)
    let end = self.index(self.startIndex, offsetBy: range.upperBound)
    return self[start..<end]
  }

  //Allow closed integer range subscripting like `string[0...n]`
  subscript(range: ClosedRange<Int>) -> Substring {
    let start = self.index(self.startIndex, offsetBy: range.lowerBound)
    let end = self.index(self.startIndex, offsetBy: range.upperBound)
    return self[start...end]
  }
    
}
