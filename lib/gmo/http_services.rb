require "cgi"
require "gmo/json"

module Gmo
  class Response

    attr_reader :status, :body, :headers
    def initialize(status, body, headers)
      @status  = status
      @body    = body
      @headers = headers
    end

  end

  module HTTPService

    def self.included(base)
      base.class_eval do
        def self.server(options = {})
          options[:host]
        end
      end# end class_eval
    end
  end

  module NetHTTPService
    def self.included(base)
      base.class_eval do
        require "net/http" unless defined?(Net::HTTP)
        require "net/https"

        include Gmo::HTTPService

        def self.make_request(path, args, verb, options = {})
          args.merge!({:method => verb}) && verb = "post" if verb != "get" && verb != "post"

          http = create_http(server(options), options)
          http.use_ssl = true

          http.start do |h|
            response = if verb == "post"
              h.post(path, encode_params(args))
            else
              h.get("#{path}?#{encode_params(args)}")
            end
            Gmo::Response.new(response.code.to_i, response.body, response)
          end
        end

        protected

          def self.encode_params(param_hash)
            ((param_hash || {}).collect do |key_and_value|
              key_and_value[1] = Gmo::JSON.dump(key_and_value[1]) if key_and_value[1].class != String
              # converting to Shift-JIS
              # -s : Shift-JIS
              # -x : 半角を維持
              sjis_value = NKF.nkf('-xs', key_and_value[1])
              "#{key_and_value[0].to_s}=#{CGI.escape sjis_value}"
            end).join("&")
          end

          def self.create_http(server, options)
            if options[:proxy]
              proxy = URI.parse(options[:proxy])
              http  = Net::HTTP.new \
                server, 443,
                proxy.host, proxy.port,
                proxy.user, proxy.password
            else
              http = Net::HTTP.new server, 443
            end
            if options[:timeout]
              http.open_timeout = options[:timeout]
              http.read_timeout = options[:timeout]
            end
            http
          end

      end
    end
  end
end
