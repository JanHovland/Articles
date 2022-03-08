//
//  ArticlesApp.swift
//  Shared
//
//  Created by Jan Hovland on 14/02/2021.
//

import SwiftUI

@main
struct ArticlesApp: App {
    @StateObject var deleteRecord = DeleteRecord()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Articles()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(deleteRecord)
        }
    }
}
