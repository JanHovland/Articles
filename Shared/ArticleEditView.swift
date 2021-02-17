//
//  ArticleEditView.swift
//  Articles
//
//  Created by Jan Hovland on 11/02/2021.
//

import SwiftUI

struct ArticleEditView: View {
    var article: Article
    
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
                saveEditArticle(title: title,
                                introduction: introduction,
                                mainType: mainType,
                                subType: subType,
                                subType1: subType1,
                                url: url)
            }, label: {
                HStack {
                    Text(NSLocalizedString("Update article", comment: "ArticleEditView"))
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text(NSLocalizedString("Edit an article", comment: "ArticleEditView"))
                .foregroundColor(.green)
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
                               space: 12,
                               value: $subType1)
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleEditView"),
                               space: 43,
                               value: $title)
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleEditView"),
                               space: 11,
                               value: $introduction)
                InputTextFieldURL(heading: NSLocalizedString("Url", comment: "ArticleEditView"),
                                  space: 62,
                                  value: $url)
                #elseif os(macOS)
                InputMainType(heading:  NSLocalizedString("MainType", comment: "ArticleEditView"),
                              mainTypes: mainTypes,
                              spaceing: 5,
                              value: $mainType)
                InputSubType(heading:   NSLocalizedString("SubType", comment: "ArticleEditView"),
                             subTypes: subTypes,
                             spaceing: 10,
                             value: $subType)
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleEditView"),
                               space: 10,
                               value: $subType1)
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleEditView"),
                               space: 57,
                               value: $title)
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleEditView"),
                               space: 50,
                               value: $introduction)
                InputTextField(heading: NSLocalizedString("Url", comment: "ArticleEditView"),
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
        .onAppear {
            title = article.title
            introduction = article.introduction
            mainType = article.mainType
            subType = article.subType
            subType1 = article.subType1
            url = article.url
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
                saveEditArticle(title: title,
                                introduction: introduction,
                                mainType: mainType,
                                subType: subType,
                                subType1: subType1,
                                url: url)
            }, label: {
                HStack {
                    Text(NSLocalizedString("Update article", comment: "ArticleEditView"))
                }
            })
        }
        .padding()
        VStack (alignment: .center){
            Text(NSLocalizedString("Edit an article", comment: "ArticleEditView"))
                .foregroundColor(.green)
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
                               space: 10,
                               value: $subType1)
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Title", comment: "ArticleEditView"),
                               space: 10,
                               value: $title)
                
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleEditView"),
                               placeHolder: NSLocalizedString("Enter Introduction", comment: "ArticleEditView"),
                               space: 60,
                               value: $introduction)
                InputTextFieldURL(heading: NSLocalizedString("Url", comment: "ArticleEditView"),
                                  placeHolder: NSLocalizedString("Enter Url", comment: "ArticleEditView"),
                                  space: 10,
                                  value: $url)
                #elseif os(macOS)
                InputMainType(heading:  NSLocalizedString("MainType", comment: "ArticleEditView"),
                              mainTypes: mainTypes,
                              spacing: 10,
                              value: $mainType)
                InputSubType(heading:   NSLocalizedString("SubType", comment: "ArticleEditView"),
                             subTypes: subTypes,
                             spacing: 10,
                             value: $subType)
                InputTextField(heading: NSLocalizedString("SubTitle1", comment: "ArticleEditView"),
                               spacing: 10,
                               value: $subType1)
                InputTextField(heading: NSLocalizedString("Title", comment: "ArticleEditView"),
                               spacing: 55,
                               value: $title)
                InputTextField(heading: NSLocalizedString("Introduction", comment: "ArticleEditView"),
                               spacing: 10,
                               value: $introduction)
                InputTextField(heading: NSLocalizedString("Url", comment: "ArticleEditView"),
                               spacing: 68,
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
        .onAppear {
            title = article.title
            introduction = article.introduction
            mainType = article.mainType
            subType = article.subType
            subType1 = article.subType1
            url = article.url
        }
    } /// var Body
    #endif
    
    func saveEditArticle(title: String,
                         introduction: String,
                         mainType: Int,
                         subType: Int,
                         subType1: String,
                         url: String) {
        
        /// Alle feltene må ha verdi
        if  title.count > 0,
            introduction.count > 0,
            subType1.count > 0,
            url.count > 0  {
            if url.contains("https") ||
                url.contains("http")    {
                if url.contains("://"),
                   url.contains(".") {
                    /// Sjekker om denne posten finnes fra før
                    CloudKitArticle.doesArticleExist(url: url) { (result) in
                        if result == false {
                            let message0 = NSLocalizedString("Url error", comment: "saveEditArticle")
                            message = message0 + " : \n" + url
                            message1 = NSLocalizedString("Check that the url contains https:// or http://, but some url only accepts https", comment: "saveEditArticle")
                            alertIdentifier = AlertID(id: .first)
                        } else {
                            /// Personen finnes i Artikkel tabellen
                            /// Må finne recordID for den enkelte artikkelen
                            let predicate = NSPredicate(format: "url == %@", url)
                            CloudKitArticle.fetchArticle(predicate: predicate)  { (result) in
                                switch result {
                                /// Finne recordID for å kunne oppdatere artikkelen
                                case .success(let article):
                                    let recordID = article.recordID
                                    let article = Article(
                                        recordID: recordID,
                                        title: title,
                                        introduction: introduction,
                                        mainType: mainType,
                                        subType: subType,
                                        subType1: subType1,
                                        url: url)
                                    /// Oppdatere artikkelen
                                    CloudKitArticle.modifyArticle(item: article) { (res) in
                                        switch res {
                                        case .success:
                                            
                                            /// Finner ikke message og message1
                                            
                                            print("Updated data")
                                            
                                            message = NSLocalizedString("Updated data", comment: "saveEditArticle")
                                            message1 = NSLocalizedString("This article is now updated", comment: "saveEditArticle")
                                            alertIdentifier = AlertID(id: .first)
                                        case .failure(let err):
                                            message = err.localizedDescription
                                            alertIdentifier = AlertID(id: .second)
                                        }
                                    }
                                case .failure(let err):
                                    let _ = err.localizedDescription
                                }
                            }
                        }
                    }
                } else {
                    message = NSLocalizedString("Incorrect url", comment: "saveEditArticle")
                    message1 = NSLocalizedString("Check that the rest of the url following http is valid.", comment: "AddArticleView")
                    alertIdentifier = AlertID(id: .first)
                }
            } else {
                message = NSLocalizedString("Incorrect url", comment: "saveEditArticle")
                message1 = NSLocalizedString("Check that the url contains https:// or http://, but some url only accepts https", comment: "saveEditArticle")
                alertIdentifier = AlertID(id: .first)
            }
        } else {
            message = NSLocalizedString("Missing Article Data", comment: "saveEditArticle")
            message1 = NSLocalizedString("Check that all fields have a value", comment: "saveEditArticle")
            alertIdentifier = AlertID(id: .first)
        }
    }
    
}

