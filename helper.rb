module CucumberHelper
    require 'faraday'
    require 'openssl'
    require 'base64'
    require 'json'
 
     def self.delete_request(data, path)
        conn = Faraday.new(:url => 'http://127.0.0.1:3001') do |faraday|
          faraday.adapter  Faraday.default_adapter 
        end
        url = conn.build_url(path, data)
        response = conn.delete(url.to_s)
        response
    end
       
    def self.request(data, path)
        conn = Faraday.new(:url => 'http://127.0.0.1:3001') do |faraday|
          faraday.adapter  Faraday.default_adapter 
        end
        
        response = conn.post do |req|
            Capybara.current_session
            req.url path
            req.headers['Content-Type'] = "application/json"
            req.body = JSON.generate(data)
            req.headers['Content-Length'] = req.body.length.to_s
        end
        response
    end
    
    def self.signed_request(data, path, api_key, api_secret)
        conn = Faraday.new(:url => 'http://127.0.0.1:3001') do |faraday|
          faraday.adapter  Faraday.default_adapter 
        end
        
        response = conn.post do |req|
            Capybara.current_session
            req.url '/api' + path
            req.headers['Content-Type'] = "application/json"
            req.body = JSON.generate(data)
            req.headers['Content-Length'] = req.body.length.to_s
            req.headers['Authentication'] = api_key + ':' + sign_request(req, api_secret) 
        end
        response
    end
    
    def self.sign_request(request, secret)
        digest = OpenSSL::Digest::Digest.new('sha1')
        Base64.encode64(OpenSSL::HMAC.digest(digest, secret, canonical_string(request))).strip
    end
    
    def self.canonical_string(request)
        method = request.method.to_s.upcase
        content_type = request.headers['Content-Type']
        content_md5 = ''
        content_length = request.headers['Content-Length']
        date = ''
        path = request.respond_to?(:unparsed_uri) ? request.unparsed_uri : request.path
        canonical_str = method + content_type + content_md5 + content_length + date + path
        canonical_str
    end
end