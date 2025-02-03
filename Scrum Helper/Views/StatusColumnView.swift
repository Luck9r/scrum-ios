//
//  StatusColumnView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//


import SwiftUI

struct StatusColumnView: View {
    var status: Status
    var tasks: [Task]?
    
    var body: some View {
        VStack {
            Text(status.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.teal.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top, 15)
            
            if let tasks = tasks {
                ScrollView {
                    ForEach(tasks.filter { $0.statusId == status.id }, id: \.id) { task in
                        NavigationLink(destination: TaskView(task: task)) {
                            TaskCardView(task: task)
                        }
                    }
                }
                Spacer()
            }
        }
        .frame(width: 300)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
    }
}
