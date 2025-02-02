//
//  LoginView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//


import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @ObservedObject var authState: AuthenticationState

    var body: some View {
        VStack(spacing: 20) {
            // App Icon
            Image(.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 40)

            // App Title
            Text("Scrum Helper")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Input Fields
            VStack(spacing: 15) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .textContentType(.password)
                    .autocapitalization(.none)
            }
            .padding(.horizontal)

            // Login Button
            Button(action: {
                viewModel.login(authState: authState)
            }) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Login")
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isLoading ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 3)
            }
            .disabled(viewModel.isLoading)
            .padding(.horizontal)

            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .transition(.opacity)
            }

            Spacer()
        }
        .padding(.horizontal, 30)
        .animation(.easeInOut, value: viewModel.errorMessage)
    }
}

#Preview {
    LoginView(authState: AuthenticationState())
}
