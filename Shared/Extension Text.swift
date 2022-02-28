//
//  Extension Text.swift
//  Articles
//
//  Created by Jan Hovland on 24/02/2022.
//

import SwiftUI

func attributedString(_ str: String) -> AttributedString {
    var string = AttributedString()
    var s = AttributedString()
    var wordArray = [String]()
    var word = ""
    
    let punctuation = [".", " ", "=", "[", "]", "(", "\n", "/", "$", ")", "_", ",", ":"]
    
    let count = str.count
    for i in 0..<count {
        let char = str[i]
        if punctuation.contains(String(char)) {
            if word.count > 0 {
                wordArray.append(word)
                word = ""
            }
            wordArray.append(String(char))
        } else {
            word.append(String(char))
        }
    }
    
    let wordArray1 = ["font", "foregroundColor", "resizable", "frame", "title", "weight", "width", "heavy", "height", "alignment", "center", "yellow", "gesture", "toggle"]
    let wordArray2 = ["Image", "Font", "systemName", "TapGesture", "onEnded"]

    let teller = wordArray.count
    for i in 0..<teller {
        let t = wordArray[i]
        if wordArray1.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(red: 178/255, green: 130/255, blue: 235/255)
            string = string + s
        } else if wordArray2.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(red: 209/255, green: 179/255, blue: 245/255)
            string = string + s
        } else {
            string = string + AttributedString(t)
        }
    }
    
    /// alle tall settes til gul
    let characterView = string.characters
    
    for i in characterView.indices where characterView[i].isNumber {
        string[i..<characterView.index(after: i)].foregroundColor = Color(red: 216/255, green: 200/255, blue: 123/255)
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
