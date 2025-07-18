//
//  RepoListView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import SwiftUI

// MARK: - User Repo List
struct RepoListView: View {
    let repos: [GitHubRepo]
    let onRefresh: () async throws -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("User Repositories")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                LazyVStack(spacing: 12.0) {
                    ForEach(repos) { repo in
                        getRepoDetails(user: repo)
                    }
                }
                .refreshable {
                    do {
                        try await onRefresh()
                    } catch {
                        print("Refresh failed:", error.localizedDescription)
                    }
                }
        }
        .padding(.vertical)
    }
    @ViewBuilder
    func getRepoDetails(user: GitHubRepo) -> some View {
        CardView(customBackgroundColor: Color.blue.opacity(0.1)) {
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                    .foregroundStyle(Color.blue)
                
                if let description = user.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Label("\(user.stargazers_count)", systemImage: "star.fill")
                    Label("\(user.forks_count)", systemImage: "tuningfork")
                }
                .font(.caption)
            }
        }
    }
}
