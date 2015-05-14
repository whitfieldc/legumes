module HackerNews

  class Client
    include HTTParty


    def initialize
    @base_uri = "http://localhost:9494"

    end

    def get(route)
      result = HTTParty.get(@base_uri+route).parsed_response
      # @result= JSON.parse(result)
    end

    def post(route, params)
      @post_response = HTTParty.post(
                                    @base_uri + route,
                                    headers: @headers,
                                    body: params
                                    )
    end

  end

end
