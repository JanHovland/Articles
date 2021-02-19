//
//  SwiftUIViewModifer.swift
//  Articles
//
//  Created by Jan Hovland on 17/02/2021.
//

import SwiftUI

struct Modifier01: ViewModifier {                              
    #if os(iOS)
    func body(content: Content) -> some View {
        content
            /// Ta bort tastaturet når en klikker utenfor feltet
            .modifier(DismissingKeyboard())
//            /// Flytte opp feltene slik at keyboard ikke skjuler aktuelt felt
//            .modifier(AdaptsToSoftwareKeyboard())
    }
    #elseif os(macOS)
    func body(content: Content) -> some View {
        content
    }
    #endif
}

extension View {
  func modifier01() -> some View {
    modifier(Modifier01())
  }
}

///
/// Slik kan den brukes
///
//  Text("Hello World!")
//      .modifier01()
