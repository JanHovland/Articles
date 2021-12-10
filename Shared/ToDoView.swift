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
    
      1. 🟢 Legg inn async await på CloudKit.
      2. 🟢 Ny Search bar iOS 15.
      3. 🟢 Tastaturet skjuler ikke feltet lenger.
      4. 🟢 Etter å ha valgt en post blir **alle** postene i viewet valgt.
      5. 🟢 Rett sletting på macOS
      6. 🟢 Sjekk lagring og lagre kun når posten ikke finnes fra før.
      7. 🔴 Legge inn ToDoView i menyen 

    
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


