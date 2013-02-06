require 'faraday'
require 'openssl'
require 'base64'
require 'json'

module Pagifyio::Client
    def self.request(options, data, api_key, api_secret)
        conn = Faraday.new(:url => "http://#{options[:host_name]}:#{options[:port]}") do |faraday|
            faraday.adapter  Faraday.default_adapter 
        end
        
        response = conn.post do |req|
            req.url options[:path]
            req.headers['Content-Type'] = "application/json"
            req.headers['Accept-Type'] = options[:accept_type]
            req.body = JSON.generate(data)
            req.headers['Content-Length'] = req.body.length.to_s
            req.headers['Date'] = Time.now().to_s
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
        date = Time.now().to_s
        path = request.respond_to?(:unparsed_uri) ? request.unparsed_uri : request.path
        canonical_str = method + content_type + content_md5 + content_length + date + path
        puts canonical_str
        canonical_str
    end    
end
