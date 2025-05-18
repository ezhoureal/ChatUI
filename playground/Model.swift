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
    var messages: [Message] = []
    
    var name: String {
        messages.last?.content.prefix(20).map(String.init).joined() ?? "New Chat"
    }
    
    init(timestamp: Date = Date()) {
        self.timestamp = timestamp
        self.messages = [Message(content: "Hello from the chatbot", author: .system)]
    }
}

@Model
final class Message: CustomStringConvertible {
    enum Author: String, Codable {
        case user, chatbot, system
    }
    
    var id = UUID()
    var timestamp = Date()
    var content: String
    var author: Author

    @Relationship(deleteRule: .cascade, inverse: \Chat.messages) // Bidirectional link
    var chat: Chat?
    
    init(content: String, author: Author) {
        self.content = content
        self.author = author
    }
    
    var description: String {
        return "Message(content: \(content), id: \(id), author: \(author))"
    }
}
