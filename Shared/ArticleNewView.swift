//
//  ArticleNewView.swift
//  Articles
//
//  Created by Jan Hovland on 04/01/2021.
//

import SwiftUI
import CloudKit

struct ArticleNewView: View {
    
    @State private var title = ""
    @State private var mainType = 0
    @State private var subType = 0
    @State private var subType1 = ""
    @State private var introduction = ""
    @State private var url = ""
    @State private var message: LocalizedStringKey = ""
    @State private var title1: LocalizedStringKey = ""
    @State private var isAlertActive = false
    
    @Environment(\.presentationMode) var presentationMode
    
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
                    let article = Article(title: title,
                                          introduction: introduction,
                                          mainType: mainType,
                                          subType: subType,
                                          subType1: subType1,
                                          url: url)
                    
                    ///
                    /// Sjekk om artikkelen finnes fra før
                    ///
                    
                    /// mainType 2 == Tips
                    ///
                     
                    var saving = false
                    
                    if mainType != 2,
                       article.url.count > 0,
                       article.url.contains("https") || article.url.contains("http"),
                       article.url.contains("://") || article.url.contains(".") {
                        saving = true
                    }
                    
                    if mainType == 2,
                       article.subType1.count > 0,
                       article.title.count > 0,
                       article.introduction.count > 0 {
                        saving = true
                    }
                    
                    if saving {
                        var value: (LocalizedStringKey, Bool)
                        value = await articleExist(article)
                        if value.0 == "" {
                            if value.1 == false {
                                message = await saveArticle(article)
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
                        
                        if mainType != 2 {
                            message = LocalizedStringKey(NSLocalizedString("The url is empty or has an illegal format", comment: ""))
                            title1 = LocalizedStringKey(NSLocalizedString("Save a new article", comment: ""))
                            isAlertActive.toggle()
                        }
                        
                        if mainType == 2 {
                            message = LocalizedStringKey(NSLocalizedString("All fields except the url, must have a value", comment: ""))
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
                              spacing: 20,
                              value: $mainType)
                InputSubType(heading: "SubType",
                             subTypes: subTypes,
                             spacing: 20,
                             value: $subType)
                
                TextField("SubTitle1", text: $subType1)
                TextField("Title", text: $title)
                TextField("Introduction", text: $introduction)
                TextField("Url", text: $url)
                
                #elseif os(macOS)
                    InputMainType(heading:  "MainType",
                                  mainTypes: mainTypes,
                                  spacing: 10,
                                  value: $mainType)
                    InputSubType(heading:   "SubType",
                                 subTypes: subTypes,
                                 spacing: 10,
                                 value: $subType)
                VStack {
                    TextField("SubTitle1", text: $subType1)
                        .padding(.bottom,10)
                    TextField("Title", text: $title)
                        .padding(.bottom,10)
                    TextField("Introduction", text: $introduction)
                        .padding(.bottom,10)
                    TextField("Url", text: $url)
                        .padding(.bottom,10)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                Spacer()
                #endif
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    var subTypes: [String]
    var spacing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing)) {
            Text(NSLocalizedString(heading, comment: ""))
            Spacer()
            Picker(selection: $value, label: Text(subTypes[value])) {
                
                /// When using ForEach in #SwiftUI with a non-constant range, remember to pass it an id. Your project will build without but your app will behave weird and you will be getting a warning "ForEach(_:content:) should only be used for *constant* data."
                
                ForEach(0 ..< subTypes.count, id: \.self) { index in
                    SelectedItemView(item: subTypes[index])
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
    var subTypes: [String]
    var spacing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spacing)) {
            Text(NSLocalizedString(heading, comment: ""))
            Picker(selection: $value, label: Text("")) {
                ForEach(0..<subTypes.count, id: \.self) { index in
                    Text(self.subTypes[index]).tag(index)
                }
            }
        }
        .padding(10)
    }
}

#endif
