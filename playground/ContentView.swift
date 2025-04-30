//
//  ContentView.swift
//  playground
//
//  Created by Tianer Zhou on 2025/4/22.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
}

struct ContentView: View {
    @State private var scroller: ScrollPosition = .init()
    @State private var inputValue = ""
    @State private var disableInput = false
    @State private var messages = [Message(content: "Hello from the chatbot")]
    @FocusState private var focused: Bool
    
    func submitText() {
        if inputValue == "" {
            return
        }
        Task { [inputValue] in
            let response = await sendMessage(message: inputValue, mock: false)
            messages.append(Message(content: response))
            disableInput = false
            focused = true
            scroller.scrollTo(edge: .bottom)
        }
        messages.append(Message(content: inputValue))
        disableInput = true
        inputValue = ""
        scroller.scrollTo(edge: .bottom)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                let _ = print("ContentView")
                ForEach(messages) { text in
                    Text(text.content)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .scrollPosition($scroller)
        
        HStack {
            TextField("This is title", text: $inputValue).border(Color.green)
                .onSubmit {
                    submitText()
                }.disabled(disableInput)
                .focused($focused)
            Button("Send") {
                submitText()
            }
        }
    }
}
#Preview {
    ContentView()
}
