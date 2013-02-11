class Pagifyio
    attr_accessor :options, :app_id, :app_secret 
    
    def initialize(id, secret)
        @app_id = id
        @app_secret = secret
        @options = {
            :host_name => "127.0.0.1",
            :port => "3000",
            :method => "POST",
            :path => "",
            :accept_type => ""
        }
    end

    def generate_pdf(template_id, data)
        requestData = {
            :template_id => template_id,
            :data => data
        };
        @options[:path] = "/api/generate_pdf"
        @options[:acceptType] = "application/pdf"
        res = Client.request(@options, requestData, @app_id, @app_secret)
        res
    end

    def list_templates
        @options[:path] = "/api/list_templates"
        @options[:acceptType] = "application/json"
        res = Client.request(@options, {}, @app_id, @app_secret)
        JSON.parse(res.body)
    end

    def new_template
        @options[:path] = "/api/new_template"
        @options[:acceptType] = "application/json"
        res = Client.request(@options, {}, @app_id, @app_secret)
        JSON.parse(res.body)
    end

    def edit_template(template_id)
        requestData = {
            :template_id => template_id
        };
        @options[:path] = "/api/edit_template"
        @options[:acceptType] = "application/json"
        res = Client.request(@options, requestData, @app_id, @app_secret)
        JSON.parse(res.body)
    end

    def delete_template(template_id)
        requestData = {
            :template_id => template_id
        };
        @options[:path] = "/api/delete_template"
        @options[:acceptType] = "application/json"
        res = Client.request(@options, requestData, @app_id, @app_secret)
        JSON.parse(res.body)
    end
end

require 'pagifyio/client'
