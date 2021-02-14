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
//struct SafariView: View {
//    var url: String
//    @Environment(\.openURL) var openURL
//    var body: some View {
//        Button("Start Safari") {
//            openURL(URL(string: url)!)
//        }
//    }
//}

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
