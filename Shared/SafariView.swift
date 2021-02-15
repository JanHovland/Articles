//
//  SafariView.swift
//  Articles
//
//  Created by Jan Hovland on 04/01/2021.
//

import SwiftUI
import CloudKit
import WebKit
import SafariServices



#if os(macOS)

/// Denne virker som test under macOS
struct WebView: NSViewRepresentable {
    
    let view: WKWebView = WKWebView()
    
    var request: URLRequest {
        get{
            let url: URL = URL(string: "https://google.com")!
            let request: URLRequest = URLRequest(url: url)
            return request
        }
    }
    
    func makeNSView(context: Context) -> WKWebView {
        view.load(request)
        return view
    }
    
    func updateNSView(_ view: WKWebView, context: Context) {
        view.load(request)
    }
    
}

/// Grunnen til at denne "ikke virket" var følgende:
/// Det mangler avhuking på :
///     Incoming Connections (Server)
///     Outgoing xonnections (Client) under:
///         TARGETS Articles (macOS) under
///             Signing & Capabilities under tab : All

struct SafariView : NSViewRepresentable {
    var url: String
    var recordID: CKRecord.ID?
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        selectedRecordId = recordID
    }
    
    func makeNSView(context: Context) -> WKWebView  {
        let view = WKWebView()
        if let url = URL(string: url) {
            view.load(URLRequest(url: url))
        }
        return view
    }
}

#elseif os(iOS)

/// Avhengig av en knapp og returnerer ikke !!
struct SafariViewIPone: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    var url: String
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 15, design: .rounded))
                        Text(NSLocalizedString("Return", comment: "ArticleEditView"))
                        
                    }
                })
                Spacer()
            }
            .padding()
            Text(NSLocalizedString("Safari View", comment: "ArticleEditView"))
                .font(.system(size: 30, weight: .ultraLight, design: .rounded))
                .padding(.top, 100)
            HStack (alignment: .center, spacing: 10) {
                Image(systemName: "info.circle")
                Text("On the iPhone (due to a software faulure?), you must press the \"Return\" key in order to go back to the overview.")
                    .padding()
            }
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundColor(.accentColor)
            .padding(.top, 50)
            .padding(.leading, 10)
            Spacer()
        }
        .onAppear {
            openURL(URL(string: url)!)
        }
    }
}

/// Denne virker kun på iPad og ikke på iPhone
/// Kan dette ha noe med beta versjonene?
struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    var url: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: URL(string: url)!)
    }
    
    func updateUIViewController(_ safariViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

#endif
