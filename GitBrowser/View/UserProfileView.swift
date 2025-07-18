//
//  UserProfileView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - User List
struct UserProfileView: View {
    let user: GitHubUser
    @Binding var isFavourite: Bool

    var body: some View {
        CardView {
            VStack(spacing: 12) {
                VStack(spacing: 8.0) {
                    WebImage(url: URL(string: user.avatar_url))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                    
                    Text(user.login)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("@\(user.login)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 16) {
                    StatCard(title: "Repositories", value: user.public_repos, color: .blue.opacity(0.1), textColor: .blue)
                    StatCard(title: "Followers", value: user.followers, color: .green.opacity(0.1), textColor: .green)
                    StatCard(title: "Following", value: user.following, color: .purple.opacity(0.1), textColor: .purple)
                }
                
                HStack {
                    Label("Joined \(user.getUserCreationDate)", systemImage: "calendar")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
        }
        .padding(.vertical)
    }
}

struct StatCard: View {
    let title: String
    let value: Int
    let color: Color
    let textColor: Color

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(textColor)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(8.0)
        .background(color)
        .cornerRadius(12)
    }
}
