namespace :setup do
  # Rake task to set up initial production data
  #
  # Example: rake setup:initialize[<first_name>,<last_name>,<username>,<email>]
  # User should be able to change password in profile edit page
  desc 'Initial production setup'
  task :initialize, %i[arg1 arg2 arg3 arg4] => :environment do |_t, args|
    puts 'Setting up initial production data...'
    
    password = SecureRandom.hex(8)
    
    user = User.find_or_create_by!(email: 'admin@example.com') do |u|
      u.first_name = args[:arg1]
      u.last_naem = args[:arg2]
      u.username = args[:arg3]
      u.email = args[:arg4]
      u.password = password
      u.password_confirmation = password
      u.confirmed_at = Time.current
    end

    puts "Created admin user: #{user.email} with password #{password}"

    # Create default About content
    About.create_by! do |a|
      a.content = 'Coming Soon!'
      a.user = user
    end

    puts 'About Created'

    # Create default Mission Statement
    MissionStatement.create do |ms|
      ms.content = 'Coming Soon!'
      ms.user = user
    end

    puts 'Mission Statement Created'

    puts 'Initial production setup complete.'
  end
end
