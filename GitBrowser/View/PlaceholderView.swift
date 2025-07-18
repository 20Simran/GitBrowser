//
//  PlaceholderView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 18/07/25.
//

import SwiftUI

// MARK: - Placeholder Before we Search 
struct PlaceholderView: View {
    var body: some View {
            VStack(spacing: 12) {
                Spacer()

                Image(systemName: "person.crop.circle.badge.questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray.opacity(0.4))

                Text("Search for a GitHub Profile")
                    .font(.headline)

                Text("Enter a username above and click search to get started")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

