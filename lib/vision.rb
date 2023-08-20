require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)

      # APIのURL作成(デプロイ時に動作するように、credentialsファイルにAPIキーを入力)
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{Rails.application.credentials.vision_api_key}"
      # 画像をbase64にエンコード
      if image_file.respond_to?(:tempfile)
        base64_image = Base64.encode64(image_file.tempfile.read)
      else
        key = image_file.key
        dir_tree = [key[0, 2], key[2, 2]]
        base64_image = Base64.encode64(open("#{Rails.root}/storage/#{dir_tree[0]}/#{dir_tree[1]}/#{image_file.key}").read)
      end
      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      # APIレスポンス出力
      if (error = response_body['responses'][0]['error']).present?
        raise error['message']
      else
        response_body['responses'][0]['labelAnnotations'].pluck('description').take(3)
      end
    end
  end
end