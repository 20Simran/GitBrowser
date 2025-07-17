//
//  UserProfileView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 17/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileView: View {
    let user: GitHubUser

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: URL(string: user.avatar_url))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())

            Text(user.login)
                .font(.title2)
                .bold()

            if let bio = user.bio {
                Text(bio)
                    .italic()
            }

            HStack {
                Text("Followers: \(user.followers)")
                Spacer()
                Text("Public Repos: \(user.public_repos)")
            }
            .font(.subheadline)
            HStack {
                Text("Following: \(user.following)")
                Spacer()
                Text(user.getUserCreationDate)
            }
            .font(.subheadline)
        }
        .padding()
    }
}


