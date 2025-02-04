//
//  MeetingRow.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 03/02/2025.
//


import SwiftUI

struct MeetingRowView: View {
    let meeting: Meeting
    @State private var showOptions = false
    
    var body: some View {
        Button(action: {showOptions.toggle()}) {
            HStack {
                VStack(alignment: .leading) {
                    Text(meeting.name)
                        .font(.headline)
                    Text(Helper.formatDate(meeting.datetime, format: "yyyy-MM-dd HH:mm"))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical, 4)
        .sheet(isPresented: $showOptions) {
            MeetingOptionsView(meeting: meeting)
                .presentationDetents([.fraction(0.4), .fraction(0.4)])
        }
    }
}
