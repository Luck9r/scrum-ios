//
//  TaskView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//


import SwiftUI

struct TaskCardView: View {
    var task: Task
    
    var body: some View {
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
                .multilineTextAlignment(.leading)
                .font(.footnote)
            
            HStack {
                if let assigneeName = task.assigneeName {
                    Text(assigneeName)
                        .font(.caption)
                        .padding(5)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                if let priority = task.priority {
                    Text(priority)
                        .font(.caption)
                        .padding(5)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Spacer()
            }
        }
        .foregroundColor(.white)
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 15)
        .padding(.top, 5)
    }
}
