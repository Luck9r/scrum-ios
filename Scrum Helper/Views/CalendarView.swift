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
    @State private var showFromPicker = false
    @State private var showToPicker = false
    
    // Date range selection
    @State private var startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: +7, to: Date()) ?? Date()
    
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFrom = dateFormatter.string(from: startDate)
        let dateTo = dateFormatter.string(from: endDate)
        
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
            // Date Pickers
            VStack {
                HStack {
                    Button(action: {
                        showFromPicker.toggle()
                    }) {
                        
                        Text("\(Helper.formatDateObject(startDate, format: "yyyy-MM-dd"))")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .sheet(isPresented: $showFromPicker) {
                                DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .presentationDetents([.fraction(0.3), .fraction(0.3)])
                            }
                    }.contentShape(Rectangle())
                    
                    Text("to")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    
                    Button(action: {
                        showToPicker.toggle()
                        print("show")
                    }) {
                        Text("\(Helper.formatDateObject(endDate, format: "yyyy-MM-dd"))")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .sheet(isPresented: $showToPicker) {
                                
                                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .presentationDetents([.fraction(0.3), .fraction(0.3)])
                            }
                    }.contentShape(Rectangle())
                    
                    
                }
                .padding()
                
                
                Button(action: fetchMeetings) {
                    Text("Find")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            
            if meetings.isEmpty {
                Text("No meetings available.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(groupedMeetings.keys.sorted(by: { date1, date2 in
                        Helper.convertToDate(date1) ?? Date() < Helper.convertToDate(date2) ?? Date()
                    }), id: \.self) { date in
                        Section(header: Text(date).font(.headline)) {
                            ForEach(groupedMeetings[date] ?? []) { meeting in
                                MeetingRowView(meeting: meeting)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Meetings")
        .onAppear {
            fetchUser()
            fetchMeetings()
        }
    }
}


