//
//  CalendarView 2.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 03/02/2025.
//


import SwiftUI

struct CalendarView: View {
    var board: Board
    @State private var user: User?
    @State private var meetings: [Meeting] = []
    
    init(board: Board) {
        self.board = board
    }
    
    func fetchUser() {
        AuthService.sendAuthenticatedRequest(url: "/user") { response, error in
            if let response = response {
                if let decodedUser = try? JSONDecoder().decode(User.self, from: response.data(using: .utf8)!) {
                    DispatchQueue.main.async {
                        self.user = decodedUser
                    }
                }
            } else {
                print("Error fetching user: \(String(describing: error))")
            }
        }
    }
    
    func fetchMeetings() {
        let dateFrom = "2025-02-01"
        let dateTo = "2025-02-28"
        AuthService.sendAuthenticatedRequest(url: "/board/\(board.id)/meetings/date-range/from/\(dateFrom)/to/\(dateTo)") { response, error in
            if let response = response {
                if let decodedMeetings = try? JSONDecoder().decode([Meeting].self, from: response.data(using: .utf8)!) {
                    DispatchQueue.main.async {
                        self.meetings = decodedMeetings
                    }
                }
            } else {
                print("Error fetching meetings: \(String(describing: error))")
            }
        }
    }
    
    
    private var groupedMeetings: [String: [Meeting]] {
        Dictionary(grouping: meetings) { meeting in
            Helper.formatDate(meeting.datetime, format: "EEEE, MMM d")
        }
    }
    
    
    var body: some View {
        VStack {
            if meetings.isEmpty {
                Text("No meetings available.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(groupedMeetings.keys.sorted(by: { date1, date2 in
                        Helper.convertToDate(date1) ?? Date() < Helper.convertToDate(date2) ?? Date()
                    }), id: \.self) { date in
                        Section(header: Text(date).font(.headline)) {
                            ForEach(groupedMeetings[date] ?? []) { meeting in
                                MeetingRow(meeting: meeting)
                            }
                        }
                    }
                }
                
            }
        }
        .onAppear {
            fetchUser()
            fetchMeetings()
        }
    }
}
