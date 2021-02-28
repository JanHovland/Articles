//
//  ArticleAllView.swift
//  Articles
//
//  Created by Jan Hovland on 04/01/2021.
//

import SwiftUI
import CloudKit

struct ArticleAllView: View {
    
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
                    Text(mainTypes[article.mainType])
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.red)
                    Text(subTypes[article.subType])
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.red)
                    hilightedText(str: article.subType1,
                                  search: searchText)
                       .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.red)
                    hilightedText(str: article.title,
                                  search: searchText)
                        .font(.system(size: 15, weight: .regular))
                    hilightedText(str: article.introduction,
                                  search: searchText)
                    Text(article.url)
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.gray)
                    #elseif os(macOS)
                    Text(mainTypes[article.mainType])
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.red)
                    Text(subTypes[article.subType])
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.red)
                    hilightedText(str: article.subType1,
                                  search: searchText)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.red)
                    hilightedText(str: article.title,
                                  search: searchText)
                        .font(.system(size: 15, weight: .regular))
                        .lineLimit(nil)
                    hilightedText(str: article.introduction,
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

func hilightedText(str: String,
                   search: String) -> Text {
    var result: Text!
    
    for word in str.split(separator: " ") {
        var text = Text(word)
        if word.contains(search) {
            ///     Finn posisjonen i word hvor search begynner
            ///     let startPos = posisjon der search begynner
            ///     let length = length of word
            ///     ext = string foran search + search + resten av word
            ///     let index2 = phone2.index(phone2.startIndex, offsetBy: 2)
            
            text = text.bold().foregroundColor(.green)
       }
        result = (result == nil ? text : result + Text(" ") + text)
    }
    return result ?? Text(str)
}
