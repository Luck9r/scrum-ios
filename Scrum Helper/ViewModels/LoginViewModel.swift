//
//  LoginViewModel.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//


import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?


    func login(authState: AuthState) {
        isLoading = true
        AuthService.login(email: email, password: password) { token, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let token = token {
                    authState.loginSuccessful()
                    print("Login successful: \(token)")
                } else {
                    self.errorMessage = error
                }
            }
        }
    }
}

