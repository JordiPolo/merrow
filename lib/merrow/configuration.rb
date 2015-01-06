#This class manages the configuration in the .merrow.yml file
require 'yaml'
require 'octokit'

class Configuration
  FILENAME= '.merrow.yml'

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
    puts "There is no access token configured in Merrow. You need to create one to access your repositories"
    puts "You will need to provide your username and password. This will be only asked once to create the access token"
    puts "The username and password will not be stored anywhere"
    puts "What is your username for Github?"
    username = gets.chomp
    puts "What is your password for Github?"
    password = gets.chomp
    token_name = "Token used by Merrow"
    client = Octokit::Client.new login: username, password: password
    auth = client.create_authorization(scopes: ["repo", "public_repo", "user"], note: token_name)
    puts "A new token has been created for your user with the name #{auth[:app][:name]}"
    auth[:token]
  rescue Octokit::Unauthorized => e
    puts "Authourization failed, user or password wrong?"
    exit(-1)
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
    if File.exist?(config_file)
      config_file
    else
      puts "Config file #{config_file}, not found. You need at least add one repository, what repository are you interested in?"
      puts "(format is user/repo like rails/rails or JordiPolo/merrow):"
      repo = gets.chomp
      if repo.match(/.*\/.*/)
        File.open(config_file,'w+'){|file| file.write( {repo: [*repo]}.to_yaml)}
        config_file
      else
        puts "Repo format not valid, run the tool again, you need to provide  username/reponame like JordiPolo/merrow"
        exit(-1)
      end
    end
  end
end
