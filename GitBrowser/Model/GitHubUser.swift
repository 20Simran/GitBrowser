//
//  GitHubUser.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import Foundation
struct GitHubUser: Codable {
    let login: String
    let avatar_url: String
    let bio: String?
    let followers: Int
    let following: Int
    let created_at: String
    let public_repos: Int
    var getUserCreationDate: String {
        let date = FCDateUtility.formatDateString(created_at,
                                                  from: "yyyy-MM-dd'T'HH:mm:ssZ",
                                                  to: "yyyy-MM-dd") ?? ""
        return date
    }
}
