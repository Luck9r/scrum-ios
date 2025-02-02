//
//  DashboardViewModel.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//


import SwiftUI


class DashboardViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var boards: [Board]?

    init() {
        getUser()
        getBoards()
    }
    
    func getUser() {
        AuthService.sendAuthenticatedRequest(url: "/user") { response, error in
            if let response = response {

                self.user = try? JSONDecoder().decode(User.self, from: response.data(using: .utf8)!)
                print("User: \(response)")
            } else {
                print("Error: \(String(describing: error))")
            }
            
        }
    }
    func getBoards() {
        AuthService.sendAuthenticatedRequest(url: "/boards") { response, error in
            if let response = response {
                self.boards = try! JSONDecoder().decode([Board].self, from: response.data(using: .utf8)!)
                print("Boards: \(response)")
            } else {
                print("\(String(describing: error))")
            }
        }
    }
    
}
