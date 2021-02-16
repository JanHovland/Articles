//
//  DismissingKeyboard.swift
//  Articles
//
//  Created by Jan Hovland on 16/02/2021.
//

import SwiftUI

#if os(iOS)
/// Dismiss the keyboard
struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}
#endif 
