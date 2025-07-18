//
//  ContentView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GitHubViewModel()
    @State private var isLoading = false
    @State private var showApiErrorMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                Text("Search and explore GitHub profiles")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                searchBar

                contentView
            }
            .padding()
            .navigationTitle("GitHub Profile Viewer")
            .toolbarTitleDisplayMode(.inline)
            .onChange(of: viewModel.username) { oldValue, newValue in
                    if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        viewModel.user = nil
                        viewModel.repos = []
                }
            }
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: 8) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Enter GitHub username", text: $viewModel.username)
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2))
            )

            Button(action: getGithubUserData) {
                Label("Search", systemImage: "person")
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(viewModel.username.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(8)
            }
            .disabled(viewModel.username.isEmpty)
        }
    }

    // MARK: - Main Content Area
    @ViewBuilder
    private var contentView: some View {
        if viewModel.username.isEmpty {
            PlaceholderView()
        } else if isLoading {
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if !showApiErrorMessage.isEmpty {
            Text(showApiErrorMessage)
                .foregroundColor(.red)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color.white)
                )
        } else if let user = viewModel.user {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    UserProfileView(
                        user: user,
                        isFavourite: Binding(
                            get: { viewModel.isFavourite(user: user) },
                            set: { _ in viewModel.toggleFavorite(user: user) }
                        )
                    )
                    RepoListView(repos: viewModel.repos) {
                        try await viewModel.fetchUserRepositories()
                    }
                }
            }
        } else {
            Spacer()
        }
    }

    // MARK: - API Call
    private func getGithubUserData() {
        isLoading = true
        showApiErrorMessage = ""
        Task {
            do {
                try await viewModel.fetchUserProfile()
                try await viewModel.fetchUserRepositories()
                
                // MARK: - Save user to Core Data
                if let user = viewModel.user {
                    CoreDataViewModel.shared.saveUserToCoreData(user)
                }
            } catch {
                showApiErrorMessage = "User not found"
            }
            isLoading = false
        }
    }
}

