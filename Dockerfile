FROM mesosphere/aws-cli

LABEL "com.github.actions.name"="Github Action for S3 up- and downloads"
LABEL "com.github.actions.description"="This action allows uploading and downloading files and directories from and to S3. This could be used to upload build/test artifacts or to cache build dependencies."
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="https://github.com/rkusa/s3-action"
LABEL "homepage"="https://github.com/rkusa/s3-action"

COPY entrypoint.sh /entrypoint.sh

ENV ENDPOINT https://s3.amazonaws.com
ENV AWS_DEFAULT_REGION eu-central-1
ENV BUCKET_NAME actions-cache

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]