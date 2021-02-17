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
    @State private var message: String = ""
    @State private var message1: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    #if os(iOS)
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 15, design: .rounded))
                    Text(NSLocalizedString("Return", comment: "ArticleNewView"))
                }
            })
            Spacer()
            Button(action: {
                saveNewArticle(titleArt: title,
                               introductionArt: introduction,
                               mainTypeArt: mainType,
                               subTypeArt: subType,
                               subType1Art: subType1,
                               urlArt: url)
            }, label: {
                HStack {
                    Text(NSLocalizedString("Save article", comment: "ArticleNewView"))
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text(NSLocalizedString("Enter a new article", comment: "ArticleEditView"))
                .font(.system(size: 30, weight: .ultraLight, design: .rounded))
        }
        Form {
            VStack {
                
                #if os(iOS)
                InputMainType(heading: NSLocalizedString("MainType", comment: "ArticleEditView"),
                              mainTypes: mainTypes,
                              spacing: 20,
                              value: $mainType)
                
                InputSubType(heading: NSLocalizedString("SubType", comment: "ArticleEditView"),
                             subTypes: subTypes,
                             spacing: 20,
                             value: $subType)
                
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter subTitle1", comment: "ArticleEditView"),
                               space: 12,
                               value: $subType1)

                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Title", comment: "ArticleEditView"),
                               space: 43,
                               value: $title)
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Introduction", comment: "ArticleEditView"),
                               space: 11,
                               value: $introduction)
 
                InputTextFieldURL(heading: NSLocalizedString("Url", comment: "ArticleEditView"),
                                  placeHolder: NSLocalizedString("Enter Url", comment: "ArticleEditView"),
                                  space: 62,
                                  value: $url)
                
                #elseif os(macOS)
                
                InputMainType(heading:  NSLocalizedString("MainType", comment: "ArticleEditView"),
                              mainTypes: mainTypes,
                              spaceing: 10,
                              value: $mainType)
                InputSubType(heading:   NSLocalizedString("SubType", comment: "ArticleEditView"),
                             subTypes: subTypes,
                             spaceing: 10,
                             value: $subType)
               
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter subTitle1", comment: "ArticleEditView"),
                               space: 10,
                               value: $subType1)
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Title", comment: "ArticleEditView"),
                               space: 57,
                               value: $title)
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Introduction", comment: "ArticleEditView"),
                               space: 50,
                               value: $introduction)
                
                InputTextField(heading: NSLocalizedString("Url", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Url", comment: "ArticleEditView"),
                               space: 71,
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
        /// Ta bort tastaturet når en klikker utenfor feltet
        .modifier(DismissingKeyboard())
        /// Flytte opp feltene slik at keyboard ikke skjuler aktuelt felt
        .modifier(AdaptsToSoftwareKeyboard())
    } /// var Body
    
    #elseif os(macOS)
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 15, design: .rounded))
                    Text(NSLocalizedString("Return", comment: "ArticleNewView"))
                }
            })
            Spacer()
            Button(action: {
                saveNewArticle(titleArt: title,
                               introductionArt: introduction,
                               mainTypeArt: mainType,
                               subTypeArt: subType,
                               subType1Art: subType1,
                               urlArt: url)
            }, label: {
                HStack {
                    Text(NSLocalizedString("Save article", comment: "ArticleNewView"))
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text(NSLocalizedString("Enter a new article", comment: "ArticleEditView"))
                .font(.system(size: 30, weight: .ultraLight, design: .rounded))
        }
        Form {
            VStack {
                
                #if os(iOS)
                InputMainType(heading: NSLocalizedString("MainType", comment: "ArticleNewView"),
                              mainTypes: mainTypes,
                              spacing: 20,
                              value: $mainType)
                
                InputSubType(heading: NSLocalizedString("SubType", comment: "ArticleNewView"),
                             subTypes: subTypes,
                             spacing: 20,
                             value: $subType)
                
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter subTitle1", comment: "ArticleNewView"),
                               space: 10,
                               value: $subType1)

                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Title", comment: "ArticleNewView"),
                               space: 10,
                               value: $title)
                
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Introduction", comment: "ArticleNewView"),
                               space: 60,
                               value: $introduction)
 
                InputTextFieldURL(heading: NSLocalizedString("Url", comment: "ArticleNewView"),
                                  placeHolder: NSLocalizedString("Enter Url", comment: "ArticleNewView"),
                                  space: 10,
                                  value: $url)
                
                #elseif os(macOS)
                
                InputMainType(heading:  NSLocalizedString("MainType", comment: "ArticleNewView"),
                              mainTypes: mainTypes,
                              spaceing: 10,
                              value: $mainType)
                
                InputSubType(heading:   NSLocalizedString("SubType", comment: "ArticleNewView"),
                             subTypes: subTypes,
                             spaceing: 10,
                             value: $subType)
               
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter subTitle1", comment: "ArticleNewView"),
                               space: 10,
                               value: $subType1)
                
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Title", comment: "ArticleNewView"),
                               space: 55,
                               value: $title)
                
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Introduction", comment: "ArticleNewView"),
                               space: 10,
                               value: $introduction)
                
                InputTextField(heading: NSLocalizedString("Url", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Url", comment: "ArticleNewView"),
                               space: 68,
                               value: $url)
                #endif
            }
            .padding()
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
    } /// var Body
    #endif
    
    func saveNewArticle(titleArt: String,
                        introductionArt: String,
                        mainTypeArt: Int,
                        subTypeArt: Int,
                        subType1Art: String,
                        urlArt: String) {
        
        /// Alle feltene må ha verdi
        if  titleArt.count > 0,
            introductionArt.count > 0,
            subType1Art.count > 0,
            urlArt.count >  0  {
            if urlArt.contains("https") ||
                urlArt.contains("http")    {
                if urlArt.contains("://"),
                   urlArt.contains(".") {
                    /// Sjekker om denne posten finnes fra før
                    CloudKitArticle.doesArticleExist(url: urlArt) { (result) in
                        if result == true {
                            message = NSLocalizedString("Existing data", comment: "AddArticleView")
                            message1 = NSLocalizedString("This article was stored earlier", comment: "AddArticleView")
                            alertIdentifier = AlertID(id: .first)
                        } else {
                            let article = Article(title: title,
                                                  introduction: introduction,
                                                  mainType: mainTypeArt,
                                                  subType: subTypeArt,
                                                  subType1: subType1Art,
                                                  url: urlArt)
                            CloudKitArticle.saveArticle(item: article) { (result) in
                                switch result {
                                case .success:
                                    title = ""
                                    introduction = ""
                                    url = ""
                                    mainType = 0
                                    subType = 0
                                    subType1 = ""
                                    message = NSLocalizedString("This article is now stored in CloudKit", comment: "AddArticleView")
                                    alertIdentifier = AlertID(id: .first)
                                case .failure(let err):
                                    message = err.localizedDescription
                                    alertIdentifier = AlertID(id: .first)
                                }
                            }
                        }
                    }
                } else {
                    message = NSLocalizedString("Incorrect url", comment: "AddArticleView")
                    message1 = NSLocalizedString("Check that the rest of the url following http is valid.", comment: "AddArticleView")
                    alertIdentifier = AlertID(id: .first)
                }
            } else {
                message = NSLocalizedString("Incorrect url", comment: "AddArticleView")
                message1 = NSLocalizedString("Check that the url contains https or http.", comment: "AddArticleView")
                alertIdentifier = AlertID(id: .first)
            }
        } else {
            message = NSLocalizedString("Missing Article Data", comment: "AddArticleView")
            message1 = NSLocalizedString("Check that all fields have a value.", comment: "AddArticleView")
            alertIdentifier = AlertID(id: .first)
        }
    }
    
}

#if os(iOS)

struct InputTextField: View {
    var heading: String
    var placeHolder: String
    var space: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(space*1.75)) {
            Text(heading)
            //            TextField(placeHolder, text: $value)
            TextEditor(text: $value)
                .lineSpacing(5)
                .lineLimit(nil)
                .allowsTightening(true)
            //                .minimumScaleFactor(0.5)
        }
        .font(.custom("Andale Mono Regular", size: 17))
        .padding(10)
    }
}

struct InputTextFieldURL: View {
    var heading: String
    var placeHolder: String
    var space: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(space*1.50)) {
            Text(heading)
            //            TextField(placeHolder, text: $value)
            TextEditor(text: $value)
                .lineSpacing(5)
                .lineLimit(nil)
                .allowsTightening(true)
            //                .minimumScaleFactor(0.5)
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
    var placeHolder: String
    var space: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(space*1.00)) {
            Text(heading)
            //            TextField(placeHolder, text: $value)
            TextEditor(text: $value)
                .lineSpacing(5)
                .lineLimit(nil)
                .allowsTightening(true)
            //                .minimumScaleFactor(0.5)
        }
        .font(.custom("Andale Mono Regular", size: 14))
        .padding(10)
    }
}

struct InputMainType: View {
    var heading: String
    var mainTypes: [String]
    var spaceing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spaceing)) {
            Text(heading)
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
    var spaceing: Int
    @Binding var value: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(spaceing)) {
            Text(heading)
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
