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
      7. 🟢 Lage meny med:
            . 🟢 Friskopp
            . 🟢 Oppgaver
      8. 🔴 .
    
    
    """
    
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
#if os(macOS)
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ReturnFromMenuView(text: "Articles")
                    }
                    Spacer()
                    Text("ToDo")
                }
                .padding(20)
                    
#endif
                VStack (alignment: .leading) {
                    Text(toDo)
                    Spacer()
                }
#if os(iOS)
                .multilineTextAlignment(.leading)
                .padding()
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("ToDo", displayMode: .inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        ControlGroup {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                ReturnFromMenuView(text: "Articles")
                            }
                        }
                        .controlGroupStyle(.navigation)
                    }
                })
#endif
            }
        }
    }
}

struct ReturnFromMenuView: View {
    var text: LocalizedStringKey
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
#if os(iOS)
                .frame(width: 11, height: 18, alignment: .center)
#else
                .frame(width: 8, height: 11, alignment: .center)
#endif
            Text(text)
        }
        .foregroundColor(.none)
        .font(Font.headline.weight(.regular))
    }
}

