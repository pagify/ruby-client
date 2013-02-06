Gem::Specification.new do |s|
    s.name        = 'pagifyio'
    s.version     = '0.1.0'
    s.summary     = "Pagify client for ruby"
    s.files       = ["lib/pagifyio.rb", "lib/pagifyio/client.rb"]
    s.add_runtime_dependency "faraday"
    s.add_runtime_dependency "json"
    s.authors     = ["Kush Kella"]
    s.email       = 'kush@pagify.io'
end