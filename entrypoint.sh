#!/bin/bash
set -e

echo "📦 Starting Android build and Telegram send..."

TOKEN="$INPUT_TOKEN"
CHAT_ID="$INPUT_CHAT_ID"
MESSAGE="$INPUT_MESSAGE"
KEYSTORE_BASE64="$INPUT_KEYSTORE_BASE64"
KEYSTORE_PASSWORD="$INPUT_KEYSTORE_PASSWORD"
KEY_ALIAS="$INPUT_KEY_ALIAS"
KEY_PASSWORD="$INPUT_KEY_PASSWORD"

# Print inputs
echo "Telegram Chat: $CHAT_ID"
echo "Build message: $MESSAGE"

# Write and decode the keystore
echo "$KEYSTORE_BASE64" | base64 -d > ./app/keystore.jks

# Make gradlew executable
chmod +x ./gradlew

# Clone repo source into the container's workspace (mounted automatically)
echo "🔧 Running Gradle assembleRelease..."
./gradlew assembleRelease

APK_PATH=$(find ./app/build/outputs/apk/release -name "*.apk" | head -n 1)

if [ ! -f "$APK_PATH" ]; then
  echo "❌ APK not found at $APK_PATH"
  exit 1
fi

echo "✅ Build complete: $APK_PATH"
echo "📤 Sending to Telegram..."

curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendDocument" \
  -F chat_id="$CHAT_ID" \
  -F caption="$MESSAGE" \
  -F document=@"$APK_PATH" \
  -F parse_mode="Markdown"

echo "✅ APK sent successfully."
