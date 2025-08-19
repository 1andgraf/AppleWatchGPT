import SwiftUI

struct ContentView: View {
    @State private var messages: [String] = []
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            ScrollViewReader { scroll in
                ScrollView {
                    VStack(spacing: 6) {
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            HStack {
                                if message.starts(with: "You:") {
                                    Spacer()
                                    Text(message)
                                        .padding(6)
                                        .background(Color.blue.opacity(0.7))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                } else {
                                    Text(message)
                                        .padding(6)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onChange(of: messages.count) {
                        if let last = messages.indices.last {
                            withAnimation {
                                scroll.scrollTo(last, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField("Message", text: $inputText)
                    .textFieldStyle(.plain)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                
                Button("Send") {
                    sendMessage(inputText)
                }
                .disabled(isLoading || inputText.isEmpty)
            }
        }
        .padding(8)
    }
    
    func sendMessage(_ message: String) {
        messages.append("You: \(message)")
        inputText = ""
        isLoading = true
        
        callAI(message: message) { response in
            DispatchQueue.main.async {
                messages.append("AI: \(response)")
                if messages.count > 10 { messages = Array(messages.suffix(10)) }
                isLoading = false
            }
        }
    }
    
    func callAI(message: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer YOUR_OPENAI_API_KEY", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."],
                ["role": "user", "content": message]
            ],
            "max_tokens": 150
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: json)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                completion("No response data")
                return
            }

            if let raw = String(data: data, encoding: .utf8) {
                print("Raw API response: \(raw)")
            }

            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = jsonObject["choices"] as? [[String: Any]],
                   let messageDict = choices.first?["message"] as? [String: Any],
                   let text = messageDict["content"] as? String {
                    completion(text.trimmingCharacters(in: .whitespacesAndNewlines))
                } else if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let errorMsg = jsonObject["error"] as? [String: Any],
                          let message = errorMsg["message"] as? String {
                    completion("API error: \(message)")
                } else {
                    completion("Could not parse AI response")
                }
            } catch {
                completion("Parsing error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
