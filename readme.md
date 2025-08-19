# Apple Watch ChatGPT Chat App

A lightweight Apple Watch app that allows you to chat with OpenAI’s ChatGPT directly from your watch. This app uses the `gpt-3.5-turbo` model via the OpenAI API.

---

## Features

- Send text messages to ChatGPT and view its responses from your Apple Watch
- Maintains the last 10 messages (for a compact chat view)

---

## Screenshots


<img width="333" height="339" alt="Screenshot 2025-08-19 at 11 30 51" src="https://github.com/user-attachments/assets/27a2d577-8c50-4ed0-9564-0a5cb3d8d37e" />
<img width="329" height="330" alt="Screenshot 2025-08-19 at 11 30 35" src="https://github.com/user-attachments/assets/e9d324d5-beeb-43a1-af6a-abd3af473421" />

---

## Requirements

- Xcode 15+
- watchOS 10+
- An OpenAI API key

---

## Installation

1. Clone this repository:

```bash
git clone https://https://github.com/1andgraf/AppleWatchGPT.git
```

2. Open the project in Xcode.
3. Replace YOUR_OPENAI_API_KEY with your OpenAI API key in `ContentView.swift`:

```swift
request.addValue("Bearer YOUR_OPENAI_API_KEY", forHTTPHeaderField: "Authorization")
```

4. Build and run on a physical Apple Watch or Watch Simulator.

---

## Important mention

- It equires an internet connection
- It uses OpenAI API, so usage counts against your API quota
- Responses are limited to 150 tokens, but it is configurable in code (max_tokens)
- You can change the ChatGPT model in `ContentView.swift`
