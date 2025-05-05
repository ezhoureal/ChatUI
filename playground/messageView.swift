//
//  messageView.swift
//  playground
//
//  Created by Tianer Zhou on 2025/5/1.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    var body: some View {
        HStack {
            if (message.author == .user) {
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            if (message.author != .user) {
                Spacer()
            }
        }
    }
}
