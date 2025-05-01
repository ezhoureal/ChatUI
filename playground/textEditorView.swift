//
//  TextEditor.swift
//  playground
//
//  Created by Tianer Zhou on 2025/5/1.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text("Ask me anything. Use Shift + Enter for new line")
                    .padding(.leading, 6)
            }
            TextEditor(text: $text)
                .opacity(text.isEmpty ? 0.85 : 1)
                .font(.system(size: 14))
        }.frame(maxHeight: 50)
    }
}

#Preview {
    ContentView()
}
