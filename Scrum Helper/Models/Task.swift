//
//  Task.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//


import Foundation

struct Task: Codable, Identifiable {
    
    let id: Int
    let slug: String
    let title: String
    let content: String?
    let dueDate: String?
    let priority: String?
    let status: String?
    let statusId: Int?
    let creatorName: String?
    let assigneeName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, title, content, dueDate = "due_date", priority, status, statusId = "status_id", creatorName = "creator_name", assigneeName = "assignee_name"
    }
}
