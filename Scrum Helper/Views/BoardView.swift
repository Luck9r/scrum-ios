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
    
    init (board: Board) {
        self.board = board
        _viewModel = StateObject(wrappedValue: BoardViewModel(board: board))
        
    }
    
    var body: some View {
        HStack {
            Text(board.title)
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading, .bottom], 25)
            Spacer()
            
            Button {
                // calendar button
                
            } label: {
                Image(systemName: "calendar")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.trailing, 25)
                
            }
        }
        .background(Color.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if viewModel.statuses.count != 0 {
                    ForEach(viewModel.statuses, id: \.id) { status in
                        VStack {
                            
                            Text(status.name)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.teal)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.top, 10)
                            
                            
                            if let tasks = viewModel.tasks {
                                
                                ForEach(tasks.filter { $0.statusId == status.id }, id: \.id) { task in
                                    VStack {
                                        HStack {
                                            Text(task.slug)
                                                .bold()
                                            Spacer()
                                            Text(task.title)
                                                .lineLimit(1)
                                            if let dueDate = task.dueDate {
                                                Spacer()
                                                Text(dueDate)
                                                    .font(.caption)
                                            }
                                        }
                                        Text(task.content ?? "")
                                            .lineLimit(3)
                                            .font(.footnote)
                                        
                                        HStack {
                                            if let assigneeName = task.assigneeName {
                                                Text(task.assigneeName)
                                                    .font(.caption)
                                                    .padding(5)
                                                    .background(Color.blue)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            }
                                            if let priority = task.priority {
                                                Text(task.priority)
                                                    .font(.caption)
                                                    .padding(5)
                                                    .background(Color.orange)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            }
                                            Spacer()
                                            
                                        }
                                        
                                        
                                    }.foregroundColor(.white)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.horizontal, 15)
                                        .padding(.top, 5)
                                    
                                    
                                    
                                }
                                Spacer()
                            }
                            
                            
                        }
                        .frame(width: 300)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
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
}


#Preview {
    BoardView(board: Board(id: 1, title: "My Board"))
}
