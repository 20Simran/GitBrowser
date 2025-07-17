//
//  RepoListView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import SwiftUI

struct RepoListView: View {
    let repos: [GitHubRepo]
    let onRefresh: () async throws -> Void

    var body: some View {
        List(repos) { repo in
            VStack(alignment: .leading) {
                Text(repo.name)
                    .font(.headline)

                if let description = repo.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Label("\(repo.stargazers_count)", systemImage: "star.fill")
                    Label("\(repo.forks_count)", systemImage: "tuningfork")
                }
                .font(.caption)
            }
            .padding(.vertical, 5)
        }
        .refreshable {
            do {
                try await onRefresh()
            } catch {
                print("Refresh failed:", error.localizedDescription)
            }
        }
    }
}
