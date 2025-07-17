//
//  GitHubViewModel.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import Foundation
class GitHubViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var user: GitHubUser?
    @Published var repos: [GitHubRepo] = []
    
    @MainActor
    func fetchUserProfile() async throws {
            guard !username.isEmpty else { return }
            let userURL = URL(string: "https://api.github.com/users/\(username)")!

            do {
                let (data, _) = try await URLSession.shared.data(from: userURL)
                let fetchedUser = try JSONDecoder().decode(GitHubUser.self, from: data)
                self.user = fetchedUser
            } catch {
                print(error.localizedDescription)
            }
        }
    
    @MainActor
    func fetchUserRepositories() async throws {
        guard !username.isEmpty else { return }
        let reposURL = URL(string: "https://api.github.com/users/\(username)/repos")!

        do {
            let (data, _) = try await URLSession.shared.data(from: reposURL)
            let fetchedRepos = try JSONDecoder().decode([GitHubRepo].self, from: data)
            self.repos = fetchedRepos
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUserCreationDate() -> String {
        let date = FCDateUtility.formatDateString(user?.created_at ?? "",
                                                  from: "yyyy-MM-dd'T'HH:mm:ssZ",
                                                  to: "yyyy-MM-dd") ?? ""
        return date
    }
}

