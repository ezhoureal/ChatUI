//
//  request.swift
//  playground
//
//  Created by Tianer Zhou on 2025/4/29.
//
import Foundation

private let url = URL(string: "https://api.deepseek.com/chat/completions")!
func sendMessage(message: String, mock: Bool) async -> String {
    if (mock) {
        try! await Task.sleep(for: .seconds(2))
        return "this is a mocked response"
    }

    let apiKey: String = ""
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    
    let requestBody: [String: Any] = [
        "model": "deepseek-chat",
        "messages": [
            ["role": "system", "content": "You are a helpful assistant."],
            ["role": "user", "content": message]
        ],
        "stream": false
    ]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
    } catch {
        print("Error creating JSON data: \(error)")
        return ""
    }
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
//        print("data = \(data), response = \(response)")
        let res = String(data: data, encoding: .utf8) ?? ""
        // todo: add deserialization and filtering
        print(res)
        return res
    } catch {
        print("Error during chat request \(error)")
        return ""
    }
}

