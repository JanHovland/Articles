//
//  ArticleEditView.swift
//  Articles
//
//  Created by Jan Hovland on 11/02/2021.
//

import SwiftUI
import CloudKit

struct ArticleEditView: View {
    var article: Article
    
    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var mainType = 0
    @State private var subType = 0
    @State private var subType1 = ""
    @State private var introduction = ""
    @State private var url = ""
    @State private var message: LocalizedStringKey = ""
    @State private var message1: LocalizedStringKey = ""
    @State private var title1: LocalizedStringKey = ""
    
    @State private var isAlertActive = false
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 15, design: .rounded))
                    Text("Return")
                }
            })
            Spacer()
            Button(action: {
                Task.init {
                   let article = Article(recordID: article.recordID,
                                         title: title,
                                         introduction: introduction,
                                         mainType: mainType,
                                         subType: subType,
                                         subType1: subType1,
                                         url: url)
                    
                    message = await modifyArticle(article)
                    title1 = "Update an article"
                    isAlertActive.toggle()
                }
            }, label: {
                HStack {
                    Text("Update article")
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text("Edit an article")
                .foregroundColor(.green)
                .font(.system(size: 30, weight: .ultraLight, design: .rounded))
        }
        Form {
            VStack {
                
#if os(iOS)
                InputMainType(heading: "MainType",
                              mainTypes: mainTypes,
                              spacing: 20,
                              value: $mainType)
                InputSubType(heading: "SubType",
                             subTypes: subTypes,
                             spacing: 20,
                             value: $subType)
                
                InputTextField(heading: "SubTitle1",
                               space: 12,
                               value: $subType1)
                InputTextField(heading: "Title",
                               space: 43,
                               value: $title)
                InputTextField(heading: "Introduction",
                               space: 11,
                               value: $introduction)
                InputTextFieldURL(heading: "Url",
                                  space: 62,
                                  value: $url)
#elseif os(macOS)
                InputMainType(heading:  "MainType",
                              mainTypes: mainTypes,
                              spacing: 5,
                              value: $mainType)
                InputSubType(heading:   "SubType",
                             subTypes: subTypes,
                             spacing: 10,
                             value: $subType)
                
                InputTextField(heading: "SubTitle1",
                               spacing: 10,
                               value: $subType1)
                InputTextField(heading: "Title",
                               spacing: 57,
                               value: $title)
                InputTextField(heading: "Introduction",
                               spacing: 11,
                               value: $introduction)
                InputTextField(heading: "Url",
                               spacing: 71,
                               value: $url)
#endif
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            title = article.title
            introduction = article.introduction
            mainType = article.mainType
            subType = article.subType
            subType1 = article.subType1
            url = article.url
        }
        .alert(title1, isPresented: $isAlertActive) {
            Button("OK", action: {})
        } message: {
            Text(message)
        }
        .modifier01()
    } /// var Body
    
}

