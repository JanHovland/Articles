//
//  ArticlesApp.swift
//  Shared
//
//  Created by Jan Hovland on 14/02/2021.
//

import SwiftUI

@main
struct ArticlesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
