//
//  TextEditor.swift
//  playground
//
//  Created by Tianer Zhou on 2025/5/1.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text("Ask me anything")
                    .padding(.leading, 6)
                    .opacity(0.8)
            }
            TextEditor(text: $text)
                .opacity(text.isEmpty ? 0.85 : 1)
                .cornerRadius(5)
                .font(.system(size: 14))
        }.frame(maxHeight: 40)
    }
}
