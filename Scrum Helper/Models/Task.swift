//
//  Task.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//

//{
//        "id": 17,
//        "slug": "GPM-1",
//        "title": "Task",
//        "content": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
//        "due_date": "2025-01-27",
//        "priority": "none",
//        "priority_id": 1,
//        "status": "QA",
//        "status_id": 30,
//        "creator_name": "Mykyta",
//        "assignee_name": "Mykyta",
//        "creator_id": 4,
//        "assignee_id": 4,
//        "board_id": 2
//    },

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
