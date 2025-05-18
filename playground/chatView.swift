//
//  chatView.swift
//  playground
//
//  Created by Tianer Zhou on 2025/5/5.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.colorScheme) var colorMode
    @Bindable var chat: Chat
    @State private var shiftPressed = false
    @State private var inputValue = ""
    @State private var disableSubmit = false
    
    @MainActor
    func submitText() {
        if inputValue == "" || disableSubmit {
            return
        }
        Task { [inputValue] in
            let response = await sendMessage(message: inputValue, mock: true)
            withAnimation(.spring) {
                chat.messages.append(Message(content: response, author: .chatbot))
                disableSubmit = false
                print("in animation submit, message = \(chat.messages)")
            }
        }
        withAnimation(.spring) {
            chat.messages.append(Message(content: inputValue, author: .user))
            disableSubmit = true
            inputValue = ""
            print("in animation submit, message = \(chat.messages)")
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(chat.messages.sorted(by: {$0.timestamp < $1.timestamp})) { message in
                    MessageView(message: message)
                        .transition(.push(from: .bottom))
                }
            }
        }
        .defaultScrollAnchor(.bottom)
        .defaultScrollAnchor(.top, for: .alignment)
        .padding(10)
        
        HStack {
            CustomTextEditor(text: $inputValue)
                .padding(5)
                .onKeyPress(.return, phases: .down) { _ in
                    if (shiftPressed) {
                        // allow new line with shift enter
                        return .ignored
                    }
                    submitText()
                    return .handled
                }
            #if MAC_OS
                .onModifierKeysChanged {old, new in
                    shiftPressed = new.contains(.shift)
                }
            #endif
            Button("Send", systemImage: "paperplane") {
                submitText()
            }
            .buttonStyle(.plain)
            .frame(minHeight: 40)
            .padding(.trailing, 15)
            .disabled(disableSubmit || inputValue.isEmpty)
        }
        .background(colorMode == .dark ? Color.black : .white)
        .padding(10)
        .clipShape(RoundedRectangle(cornerRadius: 50))
    }
}

#Preview {
    ChatView(chat: Chat())
}
