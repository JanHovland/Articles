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
                    print(title)
                    
                /*
                CoreData: CloudKit: CoreData+CloudKit: -[NSCloudKitMirroringDelegate checkAndExecuteNextRequest]_block_invoke(2856): <NSCloudKitMirroringDelegate: 0x600000340340>: No more requests to execute.
                qqqq Create a macOS Menu Bar Application Using SwiftUI
                (lldb) po article
                ▿ Article
                  ▿ id : D2858262-85F9-443E-8C14-7D9923EE840E
                    - uuid : "D2858262-85F9-443E-8C14-7D9923EE840E"
                  ▿ recordID : Optional<CKRecordID>
                    - some : <CKRecordID: 0x6000038f4440; recordName=F0B22491-B6F0-4102-AE78-BE61EEE0BA6B, zoneID=_defaultZone:__defaultOwner__>
                  - title : "Create a macOS Menu Bar Application Using SwiftUI"
                  - introduction : "Learn how to create a menu bar application using SwiftUI"
                  - mainType : 0
                  - subType : 0
                  - subType1 : ""
                  - url : "https://medium.com/@acwrightdesign/creating-a-macos-menu-bar-application-using-swiftui-54572a5d5f87"
                  */
                    
                    let artic  = Article(title: title,
                                          introduction: introduction,
                                          mainType: mainType,
                                          subType: subType,
                                          subType1: subType1,
                                          url: url)
                    
                    
                    message = await modifyArticle(artic)
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

