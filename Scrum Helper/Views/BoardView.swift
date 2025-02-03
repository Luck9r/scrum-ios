//
//  BoardView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//

import SwiftUI

struct BoardView: View {
    var board: Board
    @StateObject var viewModel: BoardViewModel
    
    init(board: Board) {
        self.board = board
        _viewModel = StateObject(wrappedValue: BoardViewModel(board: board))
    }
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if viewModel.statuses.count != 0 {
                        ForEach(viewModel.statuses, id: \.id) { status in
                            StatusColumnView(status: status, tasks: viewModel.tasks)
                        }
                    } else {
                        Text("No statuses available")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
        .navigationTitle(board.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CalendarView(board: board)) {
                    
                        Image(systemName: "calendar")
                            .padding(15)
                            
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        
    }
}


#Preview {
    BoardView(board: Board(id: 1, title: "My Board"))
}
