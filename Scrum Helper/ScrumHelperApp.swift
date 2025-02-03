//
//  Scrum_HelperApp.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//

import SwiftUI



@main
struct ScrumHelperApp: App {
    @StateObject var authState = AuthenticationState()

    var body: some Scene {
        WindowGroup {
            if authState.isLoggedIn {
                DashboardView(authState: authState)
            } else {
                LoginView(authState: authState)
            }
        }.environmentObject(authState)
    }
}
