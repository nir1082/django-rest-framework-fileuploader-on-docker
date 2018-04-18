# [DjangoRestFramework]Fileuploader on Docker

DockerでDjangoRestFrameworkのファイルアップローダーアプリを建てる

zipでアップロードされた場合は自動的に展開される

### セットアップ
sudo docker build -t [IMAGE_TAG] .

sudo docker run --name [CONTAINER_NAME] -d -p [PORT]:80 [IMAGE_TAG]

### アップロード
curl -F file=@[FILE_PATH] -F remark="REMARK" [SERVER_URL]:[PORT]/file/upload/

### ダウンロード
curl [SERVER_URL]:[PORT]/media/[FILE_NAME]
