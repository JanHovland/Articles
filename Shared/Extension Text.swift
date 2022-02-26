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
    let q : [String] =  [".",
                         "font",
                         "(",
                         "Font",
                         ".",
                         "title",
                         ".",
                         "weight",
                         "(",
                         ".",
                         "heavy",
                         ")",
                         ")"]
    let s = ".font(Font.title.weight(.heavy))"
    let count = s.count
    var value = ""
    for i in 0..<count {
        let t = s[i]
        if t == "." ||
            t == "(" ||
            t == ")" {
            print(".()")
        } else {
            print("ASCII")
            value = value + String(t)
        }
        print(value)
    }
    
    for i in 0...12 {
        string1 = AttributedString(q[i])
        if string1 == "font" {
            string1.foregroundColor = Color(.yellow)
        }
        if string1 == "Font" {
            string1.foregroundColor = Color(.green)
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
