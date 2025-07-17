//
//  GitHubRepo.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import Foundation
struct GitHubRepo: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let forks_count: Int
}
