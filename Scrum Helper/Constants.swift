//
//  Constants.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 01/02/2025.
//


enum Env {
    case development
    case production
}

struct Constants {
    static let environment: Env = .development

    static var backendURL: String {
        switch environment {
        case .development:
            return "http://macms:8000/api"
        case .production:
            return "https://scrum.luck9r.com/api"
        }
    }
}
