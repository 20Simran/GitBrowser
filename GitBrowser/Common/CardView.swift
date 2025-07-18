//
//  CardView.swift
//  GitBrowser
//
//  Created by Simran Semwal on 18/07/25.
//

import SwiftUI

struct CardView<Content: View>: View {
    var contentPadding: CGFloat? = 12
    var customBackgroundColor: Color? = Color.white

    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(contentPadding ?? 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(customBackgroundColor ?? Color.white)
                    .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
            )
            .padding(.horizontal, 16)
    }
}
