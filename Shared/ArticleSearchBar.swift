//
//  ArticleSearchBar.swift
//  Articles
//
//  Created by Jan Hovland on 14/02/2021.
//

import SwiftUI

/// SearchBar er ikke er ikke en del av SWIFTUI
struct ArticleSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    #if os(iOS)
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(.leading, 30)
                .padding(.trailing, 10)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .leading)
                        if isEditing {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    isEditing = true
                }
                .autocapitalization(.none)
            if isEditing {
                Button(action: {
                    isEditing = false
                    text = ""
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 15)
                .transition(.move(edge: .trailing))
            }
        }
    }
    #elseif os(macOS)
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search...", text: $text)
                    .padding(.leading, 5)
                    .padding(.trailing, 10)
                    .cornerRadius(8)
            }
            .padding(.leading, 10)
            .onTapGesture {
                isEditing = true
            }
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    text = ""
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
    #endif
}
