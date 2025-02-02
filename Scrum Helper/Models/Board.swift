//
//  Board.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//

import Foundation

struct Board: Codable, Identifiable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
    }
}
