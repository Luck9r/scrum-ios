//
//  BoardViewModel.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//

import Foundation

class BoardViewModel: ObservableObject {
    private let board: Board
    @Published var tasks: [Task]?
    @Published var statuses: [Status] = []
    
    init(board: Board) {
        self.board = board
        getTasks()
        getStatuses()
    }
    
    func getTasks() {
        AuthService.sendAuthenticatedRequest(url: "/board/\(board.id)/tasks") { response, error in
            if let response = response {
                self.tasks = try! JSONDecoder().decode([Task].self, from: response.data(using: .utf8)!)
                print("Tasks: \(response)")
            } else {
                print("\(String(describing: error))")
            }
        }
    }
    
    func getStatuses() {
        AuthService.sendAuthenticatedRequest(url: "/board/\(board.id)/statuses") { response, error in
            if let response = response {
                self.statuses = try! JSONDecoder().decode([Status].self, from: response.data(using: .utf8)!)
                
                print("Statuses: \(response)")
            } else {
                print("\(String(describing: error))")
            }
        }
    }
}
