//
//  MeetingOptionsView.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 03/02/2025.
//


import SwiftUI

struct MeetingOptionsView: View {
    let meeting: Meeting
    
    var body: some View {
        VStack {
            Text("Meeting Options")
                .font(.title2)
                .bold()
                .padding(.top, 10)
            
            Text(meeting.name)
                .font(.headline)
                .foregroundColor(.gray)
            
            Divider()
                .padding(.vertical, 8)
            
            Button(action: { handleOptionSelection(option: "Will Be Late") }) {
                Label("Will Be Late", systemImage: "clock.fill")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
            }
            
            Button(action: { handleOptionSelection(option: "Will Not Attend") }) {
                Label("Will Not Attend", systemImage: "xmark.circle.fill")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(10)
            }
            
            Button(action: { joinMeeting(meeting) }) {
                Label("Join Meeting", systemImage: "video.fill")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func handleOptionSelection(option: String) {
        print("\(option) selected for \(meeting.name)")
        if option == "Will Be Late" {
            sendDelayNotification()
        } else if option == "Will Not Attend" {
            sendAbsentNotification()
        }
        
    }
    
    func sendDelayNotification() {
        let parameters = ["datetime": meeting.datetime]
        AuthService.sendAuthenticatedRequest(url: "/meeting/\(meeting.id)/late", params: parameters, method: "POST") { response, error in
            if let response = response {
                print("Late notification sent: \(response)")
            } else {
                print("Error sending late notification: \(String(describing: error))")
            }
        }
    }
    
    func sendAbsentNotification() {
        let parameters = ["datetime": meeting.datetime]
        AuthService.sendAuthenticatedRequest(url: "/meeting/\(meeting.id)/absent", params: parameters, method: "POST") { response, error in
            if let response = response {
                print("Absence notification sent: \(response)")
            } else {
                print("Error sending absence notification: \(String(describing: error))")
            }
        }
    }
    
    func joinMeeting(_ meeting: Meeting) {
        if let url = URL(string: meeting.meetingLink) {
            UIApplication.shared.open(url)
        }
    }
}
