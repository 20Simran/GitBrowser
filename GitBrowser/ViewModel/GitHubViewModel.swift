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
    @Published var favouriteUser: [GitHubUser] = []
    
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
        
    func isFavourite(user: GitHubUser) -> Bool {
        favouriteUser.contains(where: { $0.login == user.login })
    }

    func toggleFavorite(user: GitHubUser) {
        if let index = favouriteUser.firstIndex(where: { $0.login == user.login }) {
            favouriteUser.remove(at: index)
        } else {
            favouriteUser.append(user)
        }
    }
}

