class Pagifyio
    attr_accessor :options, :app_id, :app_secret 
    
    def initialize(id, secret)
        @app_id = id
        @app_secret = secret
        @options = {
            :host_name => "127.0.0.1",
            :port => "3000",
            :method => "",
            :path => "",
            :accept_type => ""
        }
    end

    def generate_pdf(template_id, data)
        throw 'Please supply template_id' if (template_id == '' || template_id == nil)
        request_data = {
            :data => data
        }
        @options[:path] = "/api/templates/#{template_id}/generate_pdf"
        @options[:accept_type] = "application/pdf"
        @options[:method] = "post"
        res = Client.request(@options, request_data, @app_id, @app_secret)
        res
    end

    def list_templates
        @options[:path] = "/api/templates"
        @options[:accept_type] = "application/json"
        @options[:method] = "get"
        res = Client.request(@options, {}, @app_id, @app_secret)
        JSON.parse(res.body)
    end

    def create_template(name)
        throw 'Please supply name' if (name == '' || name == nil)
        request_data = {
            :template_name => name
        }
        @options[:path] = "/api/templates"
        @options[:accept_type] = "application/json"
        @options[:method] = "post"
        res = Client.request(@options, request_data, @app_id, @app_secret)
        JSON.parse(res.body)
    end

    def edit_template(template_id)
        throw 'Please supply template_id' if (template_id == '' || template_id == nil)
        @options[:path] = "/api/templates/#{template_id}/edit"
        @options[:accept_type] = "application/json"
        @options[:method] = "get"
        res = Client.request(@options, {}, @app_id, @app_secret)
        JSON.parse(res.body)
    end

    def delete_template(template_id)
        @options[:path] = "/api/templates/#{template_id}"
        @options[:accept_type] = "application/json"
        @options[:method] = "delete"
        res = Client.request(@options, {}, @app_id, @app_secret)
        JSON.parse(res.body)
    end
end

require 'pagifyio/client'
