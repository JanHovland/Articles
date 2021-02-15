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
    @State private var mainType = ""
    @State private var subType = ""
    @State private var subType1 = ""
    @State private var introduction = ""
    @State private var url = ""
    @State private var alertIdentifier: AlertID?
    @State private var message: String = ""
    @State private var message1: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 15, design: .rounded))
                
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
                InputTextField(heading: NSLocalizedString("mainType", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter mainType", comment: "ArticleNewView"),
                               space: 24,
                               value: $mainType)
                InputTextField(heading: NSLocalizedString("SubTitle", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter subTitle", comment: "ArticleNewView"),
                               space: 34,
                               value: $subType)
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter subTitle1", comment: "ArticleNewView"),
                               space: 26,
                               value: $subType1)
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Title", comment: "ArticleNewView"),
                               space: 57,
                               value: $title)
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Introduction", comment: "ArticleNewView"),
                               space: 10,
                               value: $introduction)
                #if os(iOS)
                InputTextFieldURL(heading: NSLocalizedString("Url", comment: "ArticleNewView"),
                                  placeHolder: NSLocalizedString("Enter Url", comment: "ArticleNewView"),
                                  space: 71,
                                  value: $url)
                #elseif os(macOS)
                InputTextField(heading: NSLocalizedString("Url", comment: "ArticleNewView"),
                               placeHolder: NSLocalizedString("Enter Url", comment: "ArticleNewView"),
                               space: 71,
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
    }
    
    func saveNewArticle(titleArt: String,
                        introductionArt: String,
                        mainTypeArt: String,
                        subTypeArt: String,
                        subType1Art: String,
                        urlArt: String) {
        
        /// Alle feltene må ha verdi
        if  titleArt.count > 0,
            introductionArt.count > 0,
            mainTypeArt.count > 0,
            subTypeArt.count > 0,
            subType1Art.count > 0,
            urlArt.count > 0  {
            if urlArt.contains("https") ||
                urlArt.contains("http") ||
                urlArt.contains("www")     ||
                urlArt.contains("://") ||
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
                                mainType = ""
                                subType = ""
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
                message1 = NSLocalizedString("Check that the url contains https:// or http://, but some url only accepts https", comment: "AddArticleView")
                alertIdentifier = AlertID(id: .first)
            }
        } else {
            message = NSLocalizedString("Missing data", comment: "AddArticleView")
            message1 = NSLocalizedString("Check that all fields have a value", comment: "AddArticleView")
            alertIdentifier = AlertID(id: .first)
        }
    }
    
}

#if os(iOS)

struct InputTextFieldURL: View {
    var heading: String
    var placeHolder: String
    var space: Double
    @Binding var value: String
    var body: some View {
        HStack(alignment: .center, spacing: CGFloat(space*1.15)) {
            Text(heading)
            TextField(placeHolder, text: $value)
        }
        .font(.custom("Andale Mono Regular", size: 17))
        .padding(10)
        .keyboardType(.URL)
        .autocapitalization(.none)
        
    }
}
#endif

struct InputTextField: View {
    var heading: String
    var placeHolder: String
    var space: Double
    @Binding var value: String
    var body: some View {
        #if os(iOS)
        HStack(alignment: .center, spacing: CGFloat(space*1.15)) {
            Text(heading)
            TextField(placeHolder, text: $value)
        }
        .font(.custom("Andale Mono Regular", size: 17))
        .padding(10)
        #elseif os(macOS)
        HStack(alignment: .center, spacing: CGFloat(space*1.00)) {
            Text(heading)
            TextField(placeHolder, text: $value)
        }
        .font(.custom("Andale Mono Regular", size: 14))
        .padding(10)
        #endif
    }
}

