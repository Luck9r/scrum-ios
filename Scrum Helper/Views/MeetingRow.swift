//
//  MeetingRow.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 03/02/2025.
//


import SwiftUI

struct MeetingRow: View {
    let meeting: Meeting
    @State private var showOptions = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(meeting.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Helper.formatDate(meeting.datetime, format: "HH:mm"))
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
            }
            
        }
        .padding(.vertical, 4)
        .onTapGesture {
            showOptions.toggle()
        }
        .sheet(isPresented: $showOptions) {
            MeetingOptionsView(meeting: meeting)
                .presentationDetents([.medium, .fraction(0.4)])
        }
    }
}
