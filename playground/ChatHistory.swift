//
//  ChatHistory.swift
//  playground
//
//  Created by Tianer Zhou on 2025/5/5.
//
import Foundation
import SwiftData

@Model
final class Chat {
    var timestamp: Date
    var messages: [Message]
    var name: String {
        get {
            guard let lastMessage = messages.last else { return "New Message" }
            return "\(lastMessage.content.prefix(20))..."
        }
    }
    init(timestamp: Date = Date()) {
        self.timestamp = timestamp
        self.messages = [Message(content: "Hello from the chatbot", author: .System)]
    }
}

@Model
final class Message: Identifiable {
    enum Author: String, Codable {
        case User, Chatbot, System
    }
    
    var id = UUID()
    var content: String
    var author: Author
    
    init(id: UUID = UUID(), content: String, author: Author) {
        self.id = id
        self.content = content
        self.author = author
    }
}
