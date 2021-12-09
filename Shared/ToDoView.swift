//
//  ToDoView.swift
//  Articles
//
//  Created by Jan Hovland on 08/12/2021.
//

import SwiftUI

struct toDoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var toDo =
    """
    
      1. 🔴 Legg inn async await på CloudKit.
      2. 🔴 Search bar iOS 15.
      3. 🔴 .
    """
    
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack (alignment: .leading) {
                    Text(toDo)
                    Spacer()
                }
                .multilineTextAlignment(.leading)
                .padding()
//                .navigationViewStyle(StackNavigationViewStyle())
//                .navigationBarTitle("ToDo", displayMode: .inline)
                .toolbar(content: {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        ControlGroup {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
//                                ReturnFromMenuView(text: "PersonOverView")
                            }
//                        }
//                        .controlGroupStyle(.navigation)
//                    }
                })
            }
        }
    }
}


