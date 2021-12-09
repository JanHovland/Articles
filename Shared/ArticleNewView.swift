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
    @State private var alertIdentifier: AlertID?
    @State private var message: LocalizedStringKey = ""
    @State private var message1: LocalizedStringKey = ""
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
                    let article = Article(title: title,
                                          introduction: introduction,
                                          mainType: mainType,
                                          subType: subType,
                                          subType1: subType1,
                                          url: url)
                    message = await saveArticle(article)
                    title1 = "Save a new article"
                    isAlertActive.toggle()
                    
                    
                    
                }
//                saveNewArticle(titleArt: title,
//                               introductionArt: introduction,
//                               mainTypeArt: mainType,
//                               subTypeArt: subType,
//                               subType1Art: subType1,
//                               urlArt: url)
            }, label: {
                HStack {
                    Text("Save article")
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text("Enter a new article")
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
                              spacing: 10,
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
                               spacing: 12,
                               value: $introduction)
                InputTextField(heading: "Url",
                               spacing: 71,
                               value: $url)
                #endif
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(item: $alertIdentifier) { alert in
            switch alert.id {
            case .first:
                return Alert(title: Text(message), message: Text(message1), dismissButton: .cancel())
            case .second:
                return Alert(title: Text(message), message: Text(message1), dismissButton: .cancel())
            case .delete:
                return Alert(title: Text(message), message: Text(message1), primaryButton: .cancel(),
                             secondaryButton: .default(Text("OK"), action: {}))
            }
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
            Text(heading)
                .foregroundColor(.green)
            Spacer()
            Picker(selection: $value, label: Text(mainTypes[value])) {
                ForEach(0 ..< mainTypes.count) { index in
                    SelectedItemView(item: mainTypes[index])
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(10)
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
            Text(heading)
                .foregroundColor(.green)
            Spacer()
            Picker(selection: $value, label: Text(subTypes[value])) {
                ForEach(0 ..< subTypes.count) { index in
                    SelectedItemView(item: subTypes[index])
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(10)
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
            Text(heading)
                .foregroundColor(.green)
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
            Text(heading)
                .foregroundColor(.green)
            Picker(selection: $value, label: Text("")) {
                ForEach(0..<mainTypes.count) { index in
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
            Text(heading)
                .foregroundColor(.green)
            Picker(selection: $value, label: Text("")) {
                ForEach(0..<subTypes.count) { index in
                    Text(self.subTypes[index]).tag(index)
                }
            }
        }
        .padding(10)
    }
}

#endif
