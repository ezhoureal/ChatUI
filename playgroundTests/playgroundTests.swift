//
//  playgroundTests.swift
//  playgroundTests
//
//  Created by Tianer Zhou on 2025/4/22.
//

import Testing
@testable import playground
struct playgroundTests {

    @Test func submit() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let mockedResponse = await sendMessage(message: "this is a test message", mock: true)
        #expect(mockedResponse == "this is a mocked response")
        
        let response = await sendMessage(message: "what happens to http requests", mock: false, apiKey: "")
        #expect(response.starts(with: "Authentication Fails"))
    }

}
