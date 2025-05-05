//
//  playgroundApp.swift
//  playground
//
//  Created by Tianer Zhou on 2025/4/22.
//

import SwiftUI

@main
struct playgroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .modelContainer(for: [Chat.self, Message.self]) // Enable SwiftData
        }
    }
}
