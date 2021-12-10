//
//  ContentView.swift
//  Shared
//
//  Created by Jan Hovland on 14/02/2021.
//

/// Kan ikke opprette en gruppe f.eks Model under Shared
/// Legger derfor disse direkte under Shared:
///     Article.swift
///     AlertID.swift
///     ArticleAllView.swift
///     CloudKitArticle.swift
///     SafariView.swift
///

import SwiftUI
import Network
import CloudKit

var selectedRecordId: CKRecord.ID?

@MainActor

struct Articles: View {
    
    @State private var articles = [Article]()
    @State private var message: LocalizedStringKey = ""
    @State private var message1: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var indexSetDelete = IndexSet()
    @State private var searchFor: String = ""
    @State private var device: LocalizedStringKey = ""
    @State private var hasConnectionPath = false
    @State private var isShowingNewView : Bool = false
    @State private var isAlertActive = false
    
    let internetMonitor = NWPathMonitor()
    let internetQueue = DispatchQueue(label: "InternetMonitor")
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        isShowingNewView.toggle()
                    }, label: {
                        HStack {
                            Text("New Article")
                        }
                    })
                    Spacer()
                    Button(action: {
                        Task.init {
                            await findAllArticles()
                        }
                    }, label: {
                        HStack {
                            Text("Refresh")
                        }
                    })
                }
                .padding(.top, 5)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                #if os(iOS)
                List {
                    ///
                    /// Søker nå i både:
                    ///     title
                    ///     introduction
                    ///     subtype1
                    ///
                    ForEach(articles.filter({ searchFor.isEmpty ||
                                                $0.title.localizedStandardContains (searchFor) ||
                                                $0.introduction.localizedStandardContains (searchFor) ||
                                                $0.subType1.localizedStandardContains (searchFor)    } )) {
                        article in
                        if UIDevice.current.model == "iPad" {
                            NavigationLink(destination: SafariView(url: article.url)) {
                                ArticleAllView(article: article,
                                               searchText: searchFor)
                            }
                        }
                        else {
                            // NavigationLink(destination: SafariViewIPone(url: article.url)) {
                            ///
                            /// Nå virker denne
                            ///
                            NavigationLink(destination: SafariView(url: article.url)) {
                                ArticleAllView(article: article,
                                               searchText: searchFor)
                            }
                        }
                    }
                    
                    
                    /// onDelete finne bare i iOS
                    .onDelete { (indexSet) in
                        indexSetDelete = indexSet
                        selectedRecordId = articles[indexSet.first!].recordID
                        Task.init {
                            await message = deleteArticle(selectedRecordId!)
                            title = "Delete"
                            isAlertActive.toggle()
                        }
                    }
                }
                /// navigationBarHidden kan kun brukes i iOS
                .navigationBarHidden(false)
                #elseif os(macOS)
                List {
                    ///
                    /// Søker nå i både:
                    ///     title
                    ///     introduction
                    ///     subtype1
                    ///
                    ForEach(articles.filter({ searchFor.isEmpty ||
                                                $0.title.localizedStandardContains (searchFor) ||
                                                $0.introduction.localizedStandardContains (searchFor) ||
                                                $0.subType1.localizedStandardContains (searchFor)    } )) {
                        article in
                        NavigationLink(destination: SafariView(url: article.url, recordID: article.recordID)) {
                            VStack (alignment: .leading) {
                                ArticleAllView(article: article,
                                               searchText: searchFor)
                            }
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                /// onDelete finne bare i macOS
                .onDeleteCommand {
                    Task.init {
                        await message = deleteArticle(selectedRecordId!)
                        title = "Delete"
                        isAlertActive.toggle()
                    }
                }
                #endif
            } // VStack
            .navigationTitle("Articles")
            .searchable(text: $searchFor, placement: .automatic, prompt: "Search...")

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            /// Sjekker internett forbindelse
            startInternetTracking()
            /// Henter alle artiklene på nytt
            await findAllArticles()
        }

        .sheet(isPresented: $isShowingNewView) {
            ArticleNewView()
        } // NavigationView
        
        .alert(title, isPresented: $isAlertActive) {
            Button("OK", action: {})
        } message: {
            Text(message)
        }

      
    } /// var body
    
    func findAllArticles() async {
        var value: (LocalizedStringKey, [Article])
        let predicate = NSPredicate(value: true)
        articles.removeAll()
        await value = findArticles(predicate)
        if value.0 != "" {
            message = value.0
            title = "Error message from the Server"
            isAlertActive.toggle()
        } else {
            articles = value.1
        }

    }
    
    func startInternetTracking() {
        /// Only fires once
        guard internetMonitor.pathUpdateHandler == nil else {
            return
        }
        internetMonitor.pathUpdateHandler = { update in
            if update.status == .satisfied {
                self.hasConnectionPath = true
            } else {
                self.hasConnectionPath = false
            }
        }
        internetMonitor.start(queue: internetQueue)
        #if os(iOS)
        /// Legger inn en forsinkelse på 1 sekund
        /// Uten denne, kan det komme melding selv om Internett er tilhjengelig
        sleep(1)
        if hasInternet() == false {
            if UIDevice.current.localizedModel == "iPhone" {
                device = "iPhone"
            } else if UIDevice.current.localizedModel == "iPad" {
                device = "iPad"
            }
            title = device
            message = "No Internet connection for this device."
            isAlertActive.toggle()
        }
        #endif
        
    }
    
    /// Will tell you if the device has an Internet connection
    /// - Returns: true if there is some kind of connection
    func hasInternet() -> Bool {
        return hasConnectionPath
    }
    
}

