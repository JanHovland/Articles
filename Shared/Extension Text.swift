//
//  Extension Text.swift
//  Articles
//
//  Created by Jan Hovland on 24/02/2022.
//

import SwiftUI

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        
        while searchStartIndex < self.endIndex,
              let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
              !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        
        return indices
    }
}

func attribute(str: String, search: String) -> AttributedString {
    var attr: AttributedString = ""
    let a = "let range = self.range(of: string, range:"
    attr = AttributedString(a)
    
    let indicies = str.indicesOf(string: "range")
    
    
    return attr
}

/*
 let keyword = "range"
 //                    1111111111222222222233333333334
 //          01234567890123456789012345678901234567890
 let html = "let range = self.range(of: string, range:"
 let indicies = html.indicesOf(string: keyword)
 print(indicies)

 for i in 0..<indicies.count {
     let value = indicies[i]
     let end = value + keyword.count
     print(html[value..<end])
 }


 */
