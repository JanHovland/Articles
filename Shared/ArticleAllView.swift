//
//  ArticleAllView.swift
//  Articles
//
//  Created by Jan Hovland on 04/01/2021.
//

import SwiftUI
import CloudKit

struct ArticleAllView: View {
    
    @State var preferredColorScheme: ColorScheme? = nil
    
    var article: Article
    var searchText: String

    @State private var isShowingEditView: Bool = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 12, height: 12, alignment: .center)
                    .font(Font.title.weight(.heavy))
                    .foregroundColor(.yellow)
                    .gesture(
                        TapGesture()
                            .onEnded({_ in
                                /// Rutine for å editere en artikkel
                                isShowingEditView.toggle()
                            })
                    )
                VStack (alignment: .leading, spacing: 5) {
                    #if os(iOS)
                    
                    HStack (spacing: 20) {
                        HilightedText(str: mainTypes[article.mainType],
                                      search: searchText)
                        HilightedText(str: subTypes[article.subType],
                                      search: searchText)
                        HilightedText(str: subTypes1[article.subType1],
                                      search: searchText)
                    }
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.red)
                    HilightedText(str: article.title,
                                  search: searchText)
                        .font(.system(size: 15, weight: .regular))
                    HilightedText(str: article.introduction,
                                      search: searchText)
                        .font(.system(size: 11, weight: .light))
                        .lineLimit(nil)
                    Text(article.url)
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.gray)
                    #elseif os(macOS)
                    
                    HStack (spacing: 20) {
                        HilightedText(str: mainTypes[article.mainType],
                                      search: searchText)
                        HilightedText(str: subTypes[article.subType],
                                      search: searchText)
                        HilightedText(str: subTypes1[article.subType1],
                                      search: searchText)
                    }
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.red)

                    HilightedText(str: article.title,
                                  search: searchText)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(nil)
                    HilightedText(str: article.introduction,
                                      search: searchText)
                        .font(.system(size: 11, weight: .light))
                        .lineLimit(nil)
                    Text(article.url)
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(.gray)
                        .lineLimit(nil)
                    #endif
                }
            }
        }
        .padding(.top, 5)
        .sheet(isPresented: $isShowingEditView) {
            ArticleEditView(article: article)
        }
    }
}

func HilightedText(str: String,
                   search: String) -> Text {
    var result: Text!
    for word in str.split(separator: " ") {
        var text = Text(word)
        if word.uppercased().contains(search.uppercased())  {
            text = text.bold().foregroundColor(.green).underline()
        }
        result = (result == nil ? text : result + Text(" ") + text)
    }
    return result ?? Text(str)
}

/// https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
