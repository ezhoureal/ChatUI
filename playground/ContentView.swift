import SwiftUI
import SwiftData

extension Array {
    subscript(safe index: Int) -> Element? {
        guard self.count > index else {return nil}
        guard index > 0 else {return self[0]}
        return self[index]
    }
}
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Chat.timestamp, order: .reverse) private var chatHistory: [Chat] // Fetches all Chat objects
    @State private var current: Chat?
    var body: some View {
        NavigationSplitView {
            List(selection: $current) {
                ForEach(chatHistory) { item in
                    NavigationLink(item.name, value: item)
                        .contextMenu {
                            deleteButton(item: item)
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .onAppear {
                current = chatHistory.first
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("New Chat", systemImage: "plus.app", action: addItem)
                }
            }
        } detail: {
            // Detail View
            if let selectedItem = current {
                ChatView(chat: selectedItem)
            } else {
                Text("Add a new chat")
            }
        }.navigationTitle("Chat")
    }
    
    private func addItem() {
        let newChat = Chat()
        withAnimation {
            modelContext.insert(newChat)
            current = newChat // Auto-select the new item
        }
    }
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                guard let toDelete = chatHistory[safe: index] else {continue}
                if toDelete == current {
                    current = (index == 0) ? chatHistory[safe: index + 1] : chatHistory[safe: index - 1]
                }
                modelContext.delete(toDelete)
            }
        }
    }
    
    @ViewBuilder
    func deleteButton(item: Chat) -> some View {
        Button("Delete", systemImage: "delete.right") {
            if let index = chatHistory.firstIndex(where: { $0.id == item.id }) {
                deleteItems(at: IndexSet(integer: index))
            }
        }
    }
}

#Preview{ContentView().modelContainer(for: Chat.self)}
