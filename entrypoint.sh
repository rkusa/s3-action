#!/bin/sh

filename="$2.tar.gz"
s3_file="s3://$BUCKET_NAME/$filename"
local_path="$3"

# TODO: check that all required env variables are set

case "$1" in
  "download")

    echo "Trying to download cache ..."
    result=$(aws s3 cp "$s3_file" "$filename" --endpoint-url $ENDPOINT 2>&1)
    if [ $? -eq 0 ]; then
      echo "Extracting cache ..."
      tar -xf "$filename" "$local_path"
      echo "Cache has been extracted ..."
      exit 0
    else
      if echo "$result" | grep -q 404; then
        echo "Couldn't restore cache, nothing cached yet ..."
        exit 0
      else
        echo "Error restoring cache ..."
        echo "$result"
        exit 1
      fi
    fi

    ;;

  "upload")

    set -e

    echo "Packing $local_path ..."
    tar -czf "$filename" "$local_path"

    echo "Uploading $filename to S3 ..."
    aws s3 --endpoint-url $ENDPOINT cp "$filename" "$s3_file"

    ;;

  *)
    echo "invalid command"
    exit 1

esac