//
//  Status.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//

import Foundation

struct Status: Codable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
