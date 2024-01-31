#!/bin/bash

FOLDER_PATH="/tmp/results/"
STORAGE_ACCOUNT_NAME="lemonstore"
CONTAINER_NAME="cont1"
SAS_TOKEN="sp=racwd&st=2024-01-30T18:23:55Z&se=2024-03-01T02:23:55Z&sv=2022-11-02&sr=c&sig=LY2KB%2F6zzdrdh3JSVj13vUAz8%2BsFJk%2BADe2AATTwB2E%3D"

# Function to upload a directory
upload_directory() {
    local directory=$1
    for file in "$directory"/*; do
        if [ -d "$file" ]; then
            # If it's a directory, recursively upload it
            upload_directory "$file"
        elif [ -f "$file" ]; then
            # If it's a file, upload it
            local blob_name="${file#$FOLDER_PATH/}" # Remove the base folder path
            echo "Uploading $file to Blob: $blob_name"
            az storage blob upload --account-name $STORAGE_ACCOUNT_NAME --container-name $CONTAINER_NAME --file "$file" --name "$blob_name" --sas-token $SAS_TOKEN
        fi
    done
}

# Start uploading from the base folder
upload_directory "$FOLDER_PATH"
