//
//  Meeting.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 03/02/2025.
//


import Foundation

struct Meeting: Codable, Identifiable {
    let id: Int
    let name: String
    let boardId: Int
    let datetime: String
    let meetingLink: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, boardId = "board_id", datetime, meetingLink = "meeting_link"
    }
}
