//
//  ContentView.swift
//  playground
//
//  Created by Tianer Zhou on 2025/4/22.
//

import SwiftUI

struct Message: Identifiable {
    enum Author {
        case User, Chatbot, System
    }
    let id = UUID()
    let content: String
    let author: Author
}

struct ContentView: View {
    @State private var inputValue = ""
    @State private var disableSubmit = false
    @State private var messages = [Message(content: "Hello from the chatbot", author: .System)]
    @FocusState private var focused: Bool
    
    @MainActor
    func submitText() {
        if inputValue == "" || disableSubmit {
            return
        }
        Task { [inputValue] in
            let response = await sendMessage(message: inputValue, mock: true)
            withAnimation(.spring) {
                messages.append(Message(content: response, author: .Chatbot))
            }
            disableSubmit = false
            focused = true
        }
        withAnimation(.spring) {
            messages.append(Message(content: inputValue, author: .User))
        }
        disableSubmit = true
        inputValue = ""
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(messages) { message in
                    MessageView(message: message)
                        .transition(.slide)
                }
            }
        }
        .defaultScrollAnchor(.bottom)
        .defaultScrollAnchor(.top, for: .alignment)
        .padding(10)
        
        HStack {
            TextEditorWithPlaceholder(text: $inputValue)
                .padding(5)
            Button("Send", systemImage: "message") {
                submitText()
            }
            .disabled(disableSubmit)
            
        }.background(Color.white)
            .padding(10)
            .frame(height: 100)
    }
}
#Preview {
    ContentView()
}
