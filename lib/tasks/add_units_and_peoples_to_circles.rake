require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

task :add_units_and_peoples_to_circles => :environment do
  # Initialize the client.
  client = Google::APIClient.new
  plusDomain = client.discovered_api('plusDomains')
  flow = Google::APIClient::InstalledAppFlow.new(
          :client_id  =>"456182194859-d899g389ufasnnt23kdfgsg3nqtu4aa6.apps.googleusercontent.com", 
          :client_secret => "C-hDNAd6Eo4F2k1uhkrztvGV", 
          :scope => ['https://www.googleapis.com/auth/plus.me','https://www.googleapis.com/auth/plus.media.upload',
                     'https://www.googleapis.com/auth/plus.profiles.read','https://www.googleapis.com/auth/plus.stream.read',
                     'https://www.googleapis.com/auth/plus.stream.write','https://www.googleapis.com/auth/plus.circles.read',
                     'https://www.googleapis.com/auth/plus.circles.write','https://www.googleapis.com/auth/userinfo.email',
                     'https://www.googleapis.com/auth/userinfo.profile'])
  client.authorization = flow.authorize
  
  circles_at_local = Unit.all.map(&:name)
  circle_list_at_google_plus = client.execute(:api_method => plusDomain.circles.list, :parameters => {'userId' => 'me'})
  circles_at_google_plus = circle_list_at_google_plus.data.items.map(&:displayName)
  circles_to_create = circles_at_local - circles_at_google_plus
  
  circles_to_create.each do |value|
    unit = Unit.find_by_name(value)
    puts "Creating new circle for #{unit.name}"
    result = client.execute(:api_method => plusDomain.circles.insert,
               :parameters => {'userId' => 'me'},
               :body =>MultiJson.dump('displayName' => unit.name),
               :headers => {'Content-Type' => 'application/json'}
            )
    unit.update_column(:circle_id, result.data.id)
  end
  
  Unit.all.each do |unit|
    puts "verify people in #{unit.name}"
    unit.employees.each do |employee|
      add_people = client.execute(
                     :api_method => plusDomain.circles.add_people,
                     :parameters => {'circleId' => unit.circle_id, 'email' => employee.email}
                   )
    puts "Employee with email id #{employee.email} added in circle #{unit.name}"
    end
  end
  
end