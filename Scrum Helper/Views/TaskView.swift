//
//  TaskView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//

import SwiftUI


struct TaskView: View {
    var task: Task
    @State private var showConfirmation = false
    @State private var user: User?
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        VStack {
            ScrollView {
                
                Text(task.slug)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    ParameterRow(label: "Due Date", value: task.dueDate ?? "-")
                    ParameterRow(label: "Priority", value: task.priority ?? "-")
                    ParameterRow(label: "Status", value: task.status ?? "-")
                    ParameterRow(label: "Creator", value: task.creatorName ?? "-")
                    ParameterRow(label: "Assignee", value: task.assigneeName ?? "-")
                }
                .padding(.horizontal)
                .padding(.bottom, 15)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text(task.content ?? "-")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                
                Spacer().onAppear() {
                    fetchUser()
                }
                if (task.assigneeId == user?.id) {
                    
                    Button(action: {
                        showConfirmation = true
                    }) {
                        Text("Will Not Complete on Time")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .opacity(0.6)
                    }
                    .padding(.vertical, 10)
                    
                }
            }
        }
        .navigationBarTitle(task.title)
        .alert("Confirm Delay", isPresented: $showConfirmation) {
            Button("Confirm", role: .destructive) {
                notifyOfTaskDelay()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you won't complete this task on time?")
        }
    }
    
    func fetchUser() {
        print("Fetching user...")
        AuthService.sendAuthenticatedRequest(url: "/user") { response, error in
            if let response = response {
                if let decodedUser = try? JSONDecoder().decode(User.self, from: response.data(using: .utf8)!) {
                    DispatchQueue.main.async {
                        print(decodedUser.id)
                        self.user = decodedUser
                    }
                }
            } else {
                print("Error fetching user: \(String(describing: error))")
            }
        }
    }
    
    func notifyOfTaskDelay() {
        AuthService.sendAuthenticatedRequest(url: "/task/\(task.id)/delay", method: "POST") { response, error in
            if let response = response {
                print("Delay notification sent: \(response)")
            } else {
                print("Error sending delay notification: \(String(describing: error))")
            }
        }
    }
}


struct ParameterRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    TaskView(task: Task(
        id: 1,
        slug: "TSK-1",
        title: "Task 1",
        content: "Lorem ipsum dolor sit amet consectetur adipiscing elit facilisis, luctus pretium nibh litora sociis lacus et, neque sed nec ante dictum ligula vulputate. Condimentum sodales lectus nisl nunc tellus faucibus sollicitudin, habitant hendrerit non facilisi ligula laoreet, turpis eu primis nullam ornare per.",
        dueDate: Date.now.formatted(),
        priority: "High",
        status: "To Do",
        statusId: 1,
        creatorName: "Mykyta Shemechko",
        assigneeName: "John Doe",
        assigneeId: 2
    ))
}
