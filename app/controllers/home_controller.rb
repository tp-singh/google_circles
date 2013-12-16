class HomeController < ApplicationController
  layout false
  def index
    if logged_in?
      auth = Signet::Rails::Factory.create_from_env :google, request.env
      client = Google::APIClient.new
      client.authorization = auth
      plusDomain = client.discovered_api('plusDomains')
      @result = client.execute(
          :api_method => plusDomain.circles.list,
          :parameters => {'userId' => 'me'}
        )
      
    end
  end
end
