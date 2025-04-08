# 📦 Build Android App & Send to Telegram

Before you start to roll-out your app on the play store, with this action you can automate the release of your Android app by sending
it to a Telegram chat or channel via a bot. 

---

## 🚀 Features

- 🔨 Builds and signs your Android app using `./gradlew assembleRelease`
- 📤 Sends the resulting `.apk` file to a Telegram chat, group, or channel
- 💬 Optional message support with Markdown formatting
- 🔐 Uses Telegram Bot API

---

## 🔧 Inputs

| Name      | Description                        | Required | Default                    |
|-----------|------------------------------------|----------|----------------------------|
| `token`   | Telegram bot token                 | ✅ Yes   | –                          |
| `chat_id` | ID of the target chat or channel   | ✅ Yes   | –                          |
| `keystore_base64` | base64 encoded string of your keystore file  | ✅ Yes   | -   |
| `keystore_password` | The password to your keystore  | ✅ Yes   | -   |
| `key_alias` | The key alias  | ✅ Yes   | -   |
| `key_password` | The key password  | ✅ Yes   | -   |
| `message` | Optional message to send with APK  | ❌ No    | `🚀 New Android Release`   |

---

## GitHub secrets
You need to set the following secrets in your GitHub repository to use this action:

| Secret Name          | Description                                      |
|----------------------|--------------------------------------------------|
| `TELEGRAM_BOT_TOKEN` | The token of your Telegram bot.                  |
| `TELEGRAM_CHAT_ID`   | The ID of the chat, group, or channel to send to.|
| `KEYSTORE_BASE64`    | Base64-encoded string of your keystore file.     |
| `KEYSTORE_PASSWORD`  | The password for your keystore.                  |
| `KEY_ALIAS`          | The alias of the key in your keystore.           |
| `KEY_PASSWORD`       | The password for the key in your keystore.       |

To set these secrets:
1. Go to your GitHub repository.
2. Navigate to **Settings** > **Secrets and variables** > **Actions**.
3. Click **New repository secret** and add each secret listed above.

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
        uses: nebiyuelias1/send-android-release-telegram-action@v1.0.5
        with:
          keystore_base64: ${{ secrets.KEYSTORE_BASE64 }}
          keystore_password: ${{ secrets.KEYSTORE_PASSWORD }}
          key_alias: ${{ secrets.KEY_ALIAS }}
          key_password: ${{ secrets.KEY_PASSWORD }}
          chat_id: ${{ secrets.TELEGRAM_CHAT_ID }}
          bot_token: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          message: "🚀 New Android release by ${{ github.actor }}!"
```

## 📥 How to Get Your Telegram `chat_id`

1. Create a bot using bot father or use an already existing bot. 
2. **Start a chat with your bot** (search by username).
3. Send a message like "Hello".
4. Open this URL: `https://api.telegram.org/bot<TOKEN>/getUpdates` (replace `<TOKEN>` with your bot token) in your browser:
5. In the response, look for.
    ```json
    "chat": {
        "id": 123456789,
    }
    ```

## 🔑 How to Create a Keystore File

To build and sign your Android app, you need a keystore file. Follow these steps to create one:

1. Open a terminal or command prompt.
2. Run the following command to generate a keystore file:
   ```bash
   keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
   ```
   Replace `my-release-key.jk`s with your desired keystore file name and `my-key-alias` with your preferred alias.
3. You will be prompted to enter the following details:
   - Keystore password
   - Key alias
   - Key password
   - Personal information (e.g., name, organization, etc.)
4. After completing the prompts, the keystore file (`my-release-key.jks`) will be created in the current directory.
5. Convert the keystore file to a Base64-encoded string:
    ```bash
    base64 my-release-key.jks > keystore_base64.txt
    ```
    This will create a file (`keystore_base64.txt`) containing the Base64-encoded string of your keystore.
6. Copy the contents of `keystore_base64.txt` and set it as the `KEYSTORE_BASE64` secret in your GitHub repository.
   > Notes:
Keep your keystore file and passwords secure. Do not share them publicly.
Use the same alias and passwords when configuring the GitHub secrets.

