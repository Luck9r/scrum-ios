//
//  User.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 02/02/2025.
//


import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
    }
}
