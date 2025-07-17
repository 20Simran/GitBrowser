//
//  ContentView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GitHubViewModel()
    @State private var isLoading: Bool = false
    @State private var showApiErrorMessage: String = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search GitHub username", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Search") {
                        getGithubUserData()
                    }
                    .padding(.trailing)
                }
                
                if isLoading {
                    Spacer()
                    ProgressView("Loading...")
                        .padding()
                } else if !showApiErrorMessage.isEmpty {
                    Text(showApiErrorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if let user = viewModel.user {
                    UserProfileView(user: user)
                    RepoListView(repos: viewModel.repos, onRefresh: {
                        try await viewModel.fetchUserRepositories()
                    })
                } else {
                    Spacer()
                }
                
                Spacer()
            }
            .navigationTitle("AirLearn GitHub Viewer")
        }
    }
    
    private func getGithubUserData() {
        isLoading = true
        Task {
            do {
                try await viewModel.fetchUserProfile()
                try await viewModel.fetchUserRepositories()
            } catch {
                showApiErrorMessage = "User not found"
                
            }
            isLoading = false
        }
    }
}
