# Apple Watch ChatGPT Chat App

A lightweight Apple Watch app that allows you to chat with OpenAI’s ChatGPT directly from your watch. This app uses the `gpt-3.5-turbo` model via the OpenAI API.

---

## Features

- Send text messages to ChatGPT from your Apple Watch
- View AI responses in a simple, scrollable chat interface
- Lightweight design optimized for watchOS
- Maintains the last 10 messages for a compact chat view

---

## Screenshots

*Add screenshots of your Apple Watch app here*

---

## Requirements

- Xcode 15+
- watchOS 10+
- An OpenAI API key

---

## Installation

1. Clone this repository:

```bash
git clone https://github.com/yourusername/apple-watch-chatgpt.git
```

2. Open the project in Xcode.
3. Replace the placeholder API key in `ContentView.swift`:

```swift
request.addValue("Bearer YOUR_OPENAI_API_KEY", forHTTPHeaderField: "Authorization")
```

4. Build and run on a physical Apple Watch or Watch Simulator.

---

## Usage

1. Open the app on your Apple Watch.
2. Type your message in the text field.
3. Tap **Send**.
4. ChatGPT’s response will appear in the chat list.

---

## Limitations

- Requires an internet connection
- Uses OpenAI API, so usage counts against your API quota
- Responses are limited to 150 tokens (configurable in code)

---

## Customization

- Change the ChatGPT model in `ContentView.swift` to try GPT-4 (requires API subscription)
- Adjust `max_tokens` to control response length

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

