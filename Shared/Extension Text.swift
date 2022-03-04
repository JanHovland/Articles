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
    
    let punctuation = [".", " ", "=", "[", "]", "(", "\n", "/", "$", ")", "_", ",", ":", "/", "{", "}", "@", "!"]
    
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
    
    let wordArray1 = [
        "Environment",
        "action",
        "alignment",
        "assign",
        "bold",
        "bottom",
        "center",
        "contains",
        "cornerRadius",
        "default",
        "edge",
        "edgesIgnoringSafeArea",
        "enabled",
        "fatalError",
        "font",
        "for",
        "foregroundColor",
        "frame",
        "gesture",
        "gray",
        "green",
        "heavy",
        "height",
        "infinity",
        "isPresented",
        "leading",
        "light",
        "lineLimit",
        "map",
        "maxWidth",
        "minHeight",
        "minWidth",
        "move",
        "none",
        "on",
        "onAppear",
        "onTapGesture",
        "overlay",
        "padding",
        "perform",
        "publisher",
        "red",
        "regular",
        "resizable",
        "separator",
        "sheet",
        "spacing",
        "split",
        "subheadline",
        "subscribe",
        "textSelection",
        "title",
        "to",
        "toggle",
        "top",
        "trailing",
        "transition",
        "underline",
        "uppercased",
        "userInfo",
        "weight",
        "width",
        "yellow",
        "zero"
    ]
    
    let wordArray2 = [
        "Button",
        "Font",
        "HStack",
        "Image",
        "LocalizedStringKey",
        "NSLocalizedString",
        "NSPredicate",
        "Spacer",
        "TapGesture",
        "Text",
        "TextField",
        "VStack",
        "compactMap",
        "endEditing",
        "completionHandler",
        "filter",
        "first",
        "fileURLWithPath",
        "isKeyWindow",
        "loadPersistentStores",
        "onEnded",
        "size",
        "system",
        "systemName",
        "windows"
    ]

    let wordArray3 = [
        "as",
        "async",
        "await",
        "catch",
        "comment",
        "do",
        "extension",
        "false",
        "for",
        "func",
        "if",
        "import",
        "in",
        "let",
        "main",
        "mutating",
        "nil",
        "private",
        "return",
        "self",
        "some",
        "static",
        "struct",
        "true",
        "try",
        "var"
    ]

    let wordArray4 = [
        "App",
        "Binding",
        "Bool",
        "CGFloat",
        "CGRect",
        "Content",
        "Edge",
        "Merge",
        "NSError",
        "NSPersistentCloudKitContainer",
        "NotificationCenter",
        "Publishers",
        "RunLoop",
        "Scene",
        "Set",
        "State",
        "String",
        "View",
        "ViewModifier",
        "WindowGroup",
        "name",
        "persistentStoreDescriptions",
        "prefix",
        "capitalized",
        "dropFirst"
    ]
    
    let wordArray5 = [
        "attributedString"
    ]

    let wordArray6 = [
        "iOS",
        "macOS",
        "#endif",
        "#elseif",
        "#if",
        "os"
    ]

    let wordArray7 = [
        "UIWindowScene",
        "body",
        "content",
        "shared"
    ]

    let wordArray8 = [
        "PersistenceController",
        "container",
        "persistenceController"
    ]

    let wordArray9 = [
        "environment",
        "managedObjectContext",
        "modifier",
        "viewContext"
    ]

    let wordArray10 = [
        "Config"
    ]

    let teller = wordArray.count
    for i in 0..<teller {
        let t = wordArray[i]
        if wordArray1.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(178, 130, 235)
            string = string + s
        } else if wordArray2.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(209, 179, 245)
            string = string + s
        } else if wordArray3.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(255, 122, 178)
            string = string + s
        } else if wordArray4.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(218, 186, 255)
            string = string + s
        } else if wordArray5.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(120, 194, 180)
            string = string + s
        } else if wordArray6.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(255, 161,  79)
            string = string + s
        } else if wordArray7.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(120, 194, 179)
            string = string + s
        } else if wordArray8.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(155, 217, 205)
            string = string + s
        } else if wordArray9.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(168, 122, 220)
            string = string + s
        } else if wordArray10.contains(t) {
            s = AttributedString(t)
            s.foregroundColor = Color(109, 200, 225)
            string = string + s
        } else {
            string = string + AttributedString(t)
        }
    }
    
    /// alle tall settes til gul
    let characterView = string.characters
    
    for i in characterView.indices where characterView[i].isNumber {
        string[i..<characterView.index(after: i)].foregroundColor = Color(216, 200, 123)
    }
    
    for i in characterView.indices where characterView[i] == "\"" {
        string[i..<characterView.index(after: i)].foregroundColor = Color(248, 127, 110)
    }
    
    for i in characterView.indices where characterView[i] == "/" {
        string[i..<characterView.index(after: i)].foregroundColor = Color(127, 140, 152)
    }
  
    for i in characterView.indices where characterView[i] == "#" {
        string[i..<characterView.index(after: i)].foregroundColor = Color(255, 161,  79)
    }
  
    for i in characterView.indices where characterView[i] == "@" {
        string[i..<characterView.index(after: i)].foregroundColor =  Color(255, 122, 128)
    }
  
    return string
}

extension Color {
    init(_ red: Int, _ green: Int, _ blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
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
