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
    
    let punctuation = [".", " ", "=", "[", "]", "(", "\n", "/", "$", ")", "_", ",", ":", "/", "{", "}", "#", "@"]
    
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
    
    let wordArray1 = ["font", "foregroundColor", "resizable", "frame", "title", "weight", "width", "heavy", "height", "alignment", "center", "yellow", "gesture", "toggle", "leading", "spacing", "Environment", "bold", "red", "textSelection", "enabled", "subheadline"
    ]
    
    let wordArray2 = ["Image", "Font", "systemName", "TapGesture", "onEnded","VStack", "HStack", "Text", "Spacer"]

    let wordArray3 = ["in", "var", "struct", "some"]

    let wordArray4 = ["String", "View"]
    
    let wordArray5 = ["attributedString"]

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
        } else if wordArray3.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(red: 255/255, green: 122/255, blue: 178/255)
            string = string + s
        } else if wordArray4.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(red: 218/255, green: 186/255, blue: 255/255)
            string = string + s
        } else if wordArray5.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(red: 120/255, green: 194/255, blue: 180/255)
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
    
    for i in characterView.indices where characterView[i] == "\"" {
        string[i..<characterView.index(after: i)].foregroundColor = Color(red: 248/255, green: 127/255, blue: 110/255)
    }
    
    for i in characterView.indices where characterView[i] == "/" {
        string[i..<characterView.index(after: i)].foregroundColor = Color(red: 127/255, green: 140/255, blue: 152/255)
    }
  
    for i in characterView.indices where characterView[i] == "#" {
        string[i..<characterView.index(after: i)].foregroundColor = Color(red: 255/255, green: 161/255, blue: 79/255)
    }
  
    for i in characterView.indices where characterView[i] == "@" {
        string[i..<characterView.index(after: i)].foregroundColor =  Color(red: 255/255, green: 122/255, blue: 178/255)
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
