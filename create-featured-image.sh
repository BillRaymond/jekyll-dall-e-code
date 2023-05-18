#!/bin/bash
set -e -x

# Set OpenAI API credentials
export OPENAI_API_KEY="JEKYLL_DALL_E"

# Generate text prompt
prompt="A dog floating in space with a beautiful view of the Earth."

# Generate image using OpenAI API
response=$(curl --location --request POST 'https://api.openai.com/v1/images' \
--header 'Authorization: Bearer '$OPENAI_API_KEY \
--header 'Content-Type: application/json' \
--data-raw '{
  "prompt": "'"$prompt"'",
  "max_tokens": 64,
  "model": "davinci"
}')

# Extract the image URL from the response
image_url=$(echo "$response" | jq -r '.images[0].output.url')

# Go to the featured-images folder
cd features-images

# Download the image
curl -OJL "$image_url"

echo "Saved the file $image_url with the following prompt: $prompt"

