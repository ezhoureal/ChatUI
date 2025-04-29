//
//  request.swift
//  playground
//
//  Created by Tianer Zhou on 2025/4/29.
//
import Foundation

final class ChatRequest {
    private let url = URL(string: "https://api.deepseek.com/chat/completions")!
    private var response: String = ""
    func sendMessage(message: String) async -> String {
        let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
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
            // Handle error appropriately
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
            }
        }
        task.resume()
        return response
    }
}
