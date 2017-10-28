module WearableApis
  class Base
    attr_reader :client, :consumer

    def initialize
      @client = nil
      @consumer = nil
    end

    def parse_response(response)
      begin
        JSON.parse(response.body)
      rescue
        nil
      end
    end
  end
end
