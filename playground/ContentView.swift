import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Chat] // Fetches all Item objects

    @State private var selectedItem: Chat? // Tracks selection

    var body: some View {
        NavigationSplitView {
            // Sidebar (Master)
            List(items, selection: $selectedItem) { item in
                NavigationLink(item.name, value: item)
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("New Chat", systemImage: "plus.app", action: addItem)
                    
                }
            }
        } detail: {
            // Detail View
            if let selectedItem = selectedItem {
                ChatView(chat: selectedItem)
            } else {
                Text("Select an item")
            }
        }
    }

    private func addItem() {
        let newItem = Chat(name: "New chat")
        withAnimation {
            modelContext.insert(newItem)
            selectedItem = newItem // Auto-select the new item
        }
    }
}

#Preview{ContentView()}
