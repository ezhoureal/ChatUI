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
    @State private var content = ""
    @State private var texts = [Message(content: "Hello from the chatbot")]
    
    func submitText() {
        if content == "" {
            return
        }
        texts.append(Message(content: content))
        Task { [content] in
            let chat = ChatRequest()
            print("during task, \(content)")
            _ = await chat.sendMessage(message: content)
        }
        content = ""
        scroller.scrollTo(edge: .bottom)
    }
    var body: some View {
        ScrollView {
            LazyVStack {
                let _ = print("ContentView")
                ForEach(texts) { text in
                    Text(text.content)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }.frame(width: 500, height: 200)
            .scrollPosition($scroller)
        HStack {
            TextField("This is title", text: $content).border(Color.green)
                .onSubmit {
                submitText()
            }
            Button("Send") {
                submitText()
            }
        }
    }
}
#Preview {
    ContentView()
}
