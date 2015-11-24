require 'rest_client'
require 'uri'
require 'json'
require_relative 'twocheckout_error'

module Twocheckout

  class Requestor

    BASE_URL = 'https://api.2checkout.com/v2/'
    SANDBOX_URL = 'https://api-sandbox.2checkout.com/v2/'

    def self.credentials(opts)
      @sellerId = opts[:sellerId]
      @privateKey = opts[:privateKey]
      @sandbox = opts[:sandbox]
    end

    def self.request(method, path, params)
      opts = setup(method,path,params)
      begin
        response = RestClient::Request.execute(opts)
        JSON.parse(response)
      rescue => e
        error_hash = JSON.parse(e.response)
        if error_hash['exception']
          raise TwoCheckoutError.new(error_hash['exception']['errorMsg'], error_hash['exception']['errorCode'])
        else
          raise TwoCheckoutError.new(error_hash['error']['message'],error_hash['error']['code'])
        end
      end
    end

    private

    def self.setup(http_method, path,params = null)
      url = @sandbox ? SANDBOX_URL : BASE_URL
      url += path

      opts = {
          :method => http_method,
          :headers => {
              :accept => :json,
              :content_type => :json
          },
          :user => @sellerId,
          :password =>  @privateKey
      }
      if http_method.to_s != 'put' && params.nil? then
        opts[:url] = url
      elsif http_method.to_s == 'get' then
        opts[:url] = url  + '?' + hash_to_query(params)
      else
        opts[:url] = url
        opts[:payload] = params ? params.to_json : null
      end
      return opts
    end

    def self.hash_to_query(hash)
      return URI.encode(hash.map{|k,v| "#{k}=#{v}"}.join("&"))
    end

  end
end
