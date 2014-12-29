#This class manages the configuration in the .jackal.yml file
require 'yaml'
require 'octokit'

class Configuration
  FILENAME= '.jackal.yml'

  def access_token
    if !data['access_token']
       data['access_token'] = create_access_token
       save(data)
    end
    data['access_token']
  end

  def repos
    data["repos"]
  end
  
  
  private

  def create_access_token
    puts "There is no access token configured in Jackal. You need to create one to access your repositories"
    puts "You will need to provide your username and password. This will be only asked once to create the access token"
    puts "The username and password will not be stored anywhere"
    puts "What is your username for Github?"
    username = gets.chomp
    puts "What is your password for Github?"
    password = gets.chomp
    token_name = "Token used by Jackal"
    client = Octokit::Client.new login: username, password: password
    auth = client.create_authorization(scopes: ["repo", "public_repo", "user"], note: token_name)
    puts "A new token has been created for your user with the name #{auth[:app][:name]}"
    auth[:token]
  end

  def save(data)
    File.open(configuration_file,'w') do |file|
      file.write data.to_yaml
    end
  end

  def data
    @data ||= YAML.load_file(configuration_file)
  end

  def configuration_file
    config_file = File.join(Dir.home, FILENAME)
    if File.exists?(config_file)
      config_file
    else
      puts "Config file #{config_file}, not found. Please create a configuration file following the instructions in the README"
      exit(-1)
    end
  end
end
