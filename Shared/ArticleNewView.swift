//
//  ArticleNewView.swift
//  Articles
//
//  Created by Jan Hovland on 04/01/2021.
//

import SwiftUI
import CloudKit
import Foundation

struct ArticleNewView: View {
    
    @State private var title = ""
    @State private var mainType = 0
    @State private var subType = 0
    @State private var subType1 = 0
    @State private var introduction = ""
    @State private var url = ""
    @State private var message: LocalizedStringKey = ""
    @State private var title1: LocalizedStringKey = ""
    @State private var isAlertActive = false
    
    @Environment(\.presentationMode) var presentationMode
    
    /// https://stackoverflow.com/questions/62848276/change-background-color-of-texteditor-in-swiftui#62848618
    
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
                    print("mainType = \(mainType)")
                    var article = Article(title: title,
                                          introduction: introduction,
                                          mainType: mainType,
                                          subType: subType,
                                          subType1: subType1,
                                          url: url)
                    
                    ///
                    /// Sjekk om artikkelen finnes fra før
                    ///
                    
                    /// subType1 1 == Tips
                    ///
                     
                    var saving = false
                    
                    if subType1 == 0,
                       article.url.count > 0,
                       article.url.contains("https") || article.url.contains("http"),
                       article.url.contains("://") || article.url.contains(".") {
                        saving = true
                    }
                    
                    if subType1 == 1,
                       article.title.count > 0,
                       article.introduction.count > 0 {
                        saving = true
                    }
                    
                    if saving {
                        var value: (LocalizedStringKey, Bool)
                        value = await articleExist(article)
                        if value.0 == "" {
                            if value.1 == false {
                                
                                if subType1 == 0 {
                                    article.subType1 = 0
                                    message = await saveArticle(article, useUrl: true)
                                } else {
                                    article.subType1 = 1
                                    message = await saveArticle(article, useUrl: false)
                                }
                                title1 = LocalizedStringKey(NSLocalizedString("Save a new article", comment: ""))
                                isAlertActive.toggle()
                            } else {
                                message = LocalizedStringKey(NSLocalizedString("This article exists i CloudKit", comment: ""))
                                title1 = LocalizedStringKey(NSLocalizedString("Save a new article", comment: ""))
                                isAlertActive.toggle()
                            }
                        } else {
                            message = value.0
                            title1 = LocalizedStringKey(NSLocalizedString("Save a new article", comment: ""))
                            isAlertActive.toggle()
                        }
                    } else {
                        
                        if subType1 == 0 {
                            message = LocalizedStringKey(NSLocalizedString("The url is empty or has an illegal format", comment: ""))
                            title1 = LocalizedStringKey(NSLocalizedString("Save a new article", comment: ""))
                            isAlertActive.toggle()
                        }
                        
                        if subType1 == 1 {
                            message = LocalizedStringKey(NSLocalizedString("All fields must have a value", comment: ""))
                            title1 = LocalizedStringKey(NSLocalizedString("Save a new article", comment: ""))
                            isAlertActive.toggle()

                        }
                    }
                }
           }, label: {
                HStack {
                    Text("Save article")
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text("Enter a new article")
                .font(.system(size: 30, weight: .ultraLight, design: .rounded))
                .padding()
        }
        Form {
            VStack {
                
                #if os(iOS)
                
                InputMainType(heading: "MainType",
                              mainTypes: mainTypes,
                              spacing: 10,
                              value: $mainType)
                
                InputSubType(heading: "SubType",
                             subType: subTypes,
                             spacing: 10,
                             value: $subType)
                
                InputSubType(heading: "SubType1",
                             subType: subTypes1,
                             spacing: 10,
                             value: $subType1)

                VStack {
                    
                    HStack (spacing: 10)  {
                        Text("Title")
                        TextEditor(text: $title)
                            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
                            .background(Color(242, 201, 173))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    HStack (spacing: 13)  {
                        Text("Introduction")
                        TextEditor(text: $introduction)
                            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
                            .background(Color(242, 201, 173))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    if subType1 == 0 {
                        HStack (spacing: 24)  {
                            Text("Url")
                            TextEditor(text: $url)
                                .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
                                .background(Color(242, 201, 173))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                }
                
                #elseif os(macOS)
                
                InputMainType(heading: "MainType",
                                  mainTypes: mainTypes,
                                  spacing: 10,
                                  value: $mainType)
                
                InputSubType(heading: "SubType",
                             subType: subTypes,
                             spacing: 10,
                             value: $subType)
                
                InputSubType(heading: "SubType1",
                             subType: subTypes1,
                             spacing: 17,
                             value: $subType1)
                VStack {
                    
                    HStack (spacing: 10)  {
                        Text("Title")
                        TextEditor(text: $title)
                            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    HStack (spacing: 13)  {
                        Text("Introduction")
                        TextEditor(text: $introduction)
                            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    if subType1 == 0 {
                        HStack (spacing: 24)  {
                            Text("Url")
                            TextEditor(text: $url)
                                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .frame(width: 400.0, height: 250)
                #endif
            }
        }
        .alert(title1, isPresented: $isAlertActive) {
            Button("OK", action: {})
        } message: {
            Text(message)
        }
        .modifier01()
    } /// var Body
    
}

#if os(iOS)

struct InputTextField: View {
    var heading: String
    var space: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(space*1.75)) {
            Text(heading)
                .foregroundColor(.green)
                .foregroundColor(.green)
            TextEditor(text: $value)
                .lineSpacing(5)
                .lineLimit(nil)
                .allowsTightening(true)
        }
        .font(.custom("Andale Mono Regular", size: 17))
        .padding(10)
    }
}

struct InputTextFieldURL: View {
    var heading: String
    var space: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(space*1.50)) {
            Text(heading)
                .foregroundColor(.green)
            TextEditor(text: $value)
                .lineSpacing(5)
                .lineLimit(nil)
                .allowsTightening(true)
        }
        .font(.custom("Andale Mono Regular", size: 17))
        .padding(10)
        .keyboardType(.URL)
        .autocapitalization(.none)
        
    }
}

///
/// https://www.hackingwithswift.com/forums/swiftui/menupickerstyle-looks-disabled/4782
///

struct InputMainType: View {
    var heading: String
    var mainTypes: [String]
    var spacing: Int
    @Binding var value: Int
    
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing)) {
            Text(NSLocalizedString(heading, comment: ""))
            Spacer()
            Picker(selection: $value, label: Text(mainTypes[value])) {
                
                /// When using ForEach in #SwiftUI with a non-constant range, remember to pass it an id. Your project will build without but your app will behave weird and you will be getting a warning "ForEach(_:content:) should only be used for *constant* data."
                
                ForEach(0 ..< mainTypes.count, id: \.self) { index in
                    SelectedItemView(item: mainTypes[index])
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    struct SelectedItemView: View, Identifiable {
        let id = UUID()
        @State var item: String
        var body: some View {
            HStack {
                Text(item)
                    .font(.headline)
            }
        }
    }
    
}

struct InputSubType: View {
    var heading: String
    var subType: [String]
    var spacing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing)) {
            Text(NSLocalizedString(heading, comment: ""))
            Spacer()
            Picker(selection: $value, label: Text(subTypes[value])) {
                
                /// When using ForEach in #SwiftUI with a non-constant range, remember to pass it an id. Your project will build without but your app will behave weird and you will be getting a warning "ForEach(_:content:) should only be used for *constant* data."
                
                ForEach(0 ..< subTypes.count, id: \.self) { index in
                    SelectedItemView(item: subType[index])
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    struct SelectedItemView: View, Identifiable {
        let id = UUID()
        @State var item: String
        var body: some View {
            HStack {
                Text(item)
                    .font(.headline)
            }
        }
    }
    
}

#elseif os(macOS)

struct InputTextField: View {
    var heading: String
    var spacing: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing*1.00)) {
            Text(NSLocalizedString(heading, comment: ""))
            TextEditor(text: $value)
                .lineSpacing(5)
                .lineLimit(nil)
                .allowsTightening(true)
        }
        .font(.custom("Andale Mono Regular", size: 14))
        .padding(10)
    }
}

struct InputMainType: View {
    var heading: String
    var mainTypes: [String]
    var spacing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing)) {
            Text(NSLocalizedString(heading, comment: ""))
            Picker(selection: $value, label: Text("")) {
                ForEach(0..<mainTypes.count, id: \.self) { index in
                    Text(self.mainTypes[index]).tag(index)
                }
            }
        }
        .padding(10)
    }
}

struct InputSubType: View {
    var heading: String
    var subType: [String]
    var spacing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing)) {
            Text(NSLocalizedString(heading, comment: ""))
            Picker(selection: $value, label: Text("")) {
                ForEach(0..<subTypes.count, id: \.self) { index in
                    Text(self.subType[index]).tag(index)
                }
            }
        }
        .padding(10)
    }
}

#endif

struct SetAttributedString: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var str: String
    var article: Article
    
    @EnvironmentObject var deleteRecord: DeleteRecord
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack (spacing: 10) {
                    Text(mainTypes[article.mainType])
                        .foregroundColor(.red)
                    Text(subTypes[article.subType])
                        .foregroundColor(.red)
                    Text(subTypes1[article.subType1])
                        .foregroundColor(.red)
                    Text(article.title)
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding(.bottom, 10)
                Text(attributedString(str))
                Spacer()
            }
            .padding(.leading, 5)
            .textSelection(.enabled)
            .font(.system(size: 15, weight: .regular))
        }
        .task {
            deleteRecord.recordId = article.recordID
        }
    }
}
