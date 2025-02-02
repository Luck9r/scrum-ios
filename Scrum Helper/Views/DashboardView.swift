//
//  DashboardView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//


import SwiftUI

struct DashboardView: View {
    @ObservedObject var authState: AuthenticationState
    @StateObject var viewModel = DashboardViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack {
                    Text("Scrum Helper")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Welcome, \(viewModel.user?.name ?? "User")")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Available Boards")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    if let boards = viewModel.boards {
                        
                        List(boards) { board in
                            NavigationLink(destination: BoardView(board: board)) {
                                HStack {
                                    Image(systemName: "list.bullet.rectangle.fill")
                                        .foregroundColor(.blue)
                                    Text(board.title)
                                        .font(.body)
                                }
                                .padding(8)
                            }
                            
                        }
                        .listStyle(.insetGrouped)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    } else {
                        Text("No boards available")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
                
                
                Button(action: {
                    AuthService.logout(authState: authState) { _, _ in }
                }) {
                    Text("Logout")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    DashboardView(authState: AuthenticationState())
}
