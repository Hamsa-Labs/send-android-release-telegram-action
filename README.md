# 📦 Build Android App & Send to Telegram

A custom GitHub Action that builds your Android project (Release APK) and sends it to a Telegram chat or channel via a bot.  
No JavaScript. No external dependencies. 100% Docker-based.

---

## 🚀 Features

- 🔨 Builds your Android app using `./gradlew assembleRelease`
- 📤 Sends the resulting `.apk` file to a Telegram chat, group, or channel
- 💬 Optional message support with Markdown formatting
- 🔐 Uses Telegram Bot API

---

## 🔧 Inputs

| Name      | Description                        | Required | Default                    |
|-----------|------------------------------------|----------|----------------------------|
| `token`   | Telegram bot token                 | ✅ Yes   | –                          |
| `chat_id` | ID of the target chat or channel   | ✅ Yes   | –                          |
| `message` | Optional message to send with APK  | ❌ No    | `🚀 New Android Release`   |

---

## 📸 Example

```yaml
name: Android Release

on:
  workflow_dispatch:

jobs:
  build-and-send:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Build & Send to Telegram
        uses: nebiyuelias1/send-android-build-telegram-action@v1
        with:
          token: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          chat_id: ${{ secrets.TELEGRAM_CHAT_ID }}
          message: |
            🚀 *New Android Release!*
            Triggered by ${{ github.actor }}
```
