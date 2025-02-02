//
//  AuthenticationState.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//

import Foundation
import SwiftUICore


class AuthenticationState: ObservableObject {
    @Published var isLoggedIn: Bool

    init() {
        isLoggedIn = KeychainService.retrieve(key: "authToken") != nil
    }

    func updateLoginStatus() {
        isLoggedIn = KeychainService.retrieve(key: "authToken") != nil
    }

    func logout() {
        KeychainService.delete(key: "authToken")
        isLoggedIn = false
    }

    func loginSuccessful() {
        isLoggedIn = true
    }
}


extension EnvironmentValues {
    var authManager: AuthenticationState {
        get { self[AuthStateKey.self] }
        set { self[AuthStateKey.self] = newValue }
    }
}

private struct AuthStateKey: EnvironmentKey {
    static let defaultValue = AuthenticationState()
}
