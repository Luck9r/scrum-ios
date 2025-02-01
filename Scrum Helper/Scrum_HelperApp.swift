//
//  Scrum_HelperApp.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//

import SwiftUI

@main
struct Scrum_HelperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
