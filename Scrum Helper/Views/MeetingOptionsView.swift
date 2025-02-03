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
        //TODO: Implement
        print("\(option) selected for \(meeting.name)")
    }
    
    func joinMeeting(_ meeting: Meeting) {
        if let url = URL(string: meeting.meetingLink) {
            UIApplication.shared.open(url)
        }
    }
}
