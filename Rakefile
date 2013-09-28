# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

desc "Setup application with default configuration & fake data"
task :setup  do
  run("rake db:drop")
  run("cp db/schema.locked db/schema.rb")
  run("rake db:create")
  run("rake db:schema:load")
  run("rake db:migrate")
  run("rake db:seed")
  run("bundle install")
end

namespace :db do

  namespace :schema do
    desc "Update the schema locked file and erase migrations"
    task :lock do
      Rake::Task["db:migrate"].invoke

      run("cp db/schema.rb db/schema.locked") if File.exists?("./db/schema.rb")
      run("rm -f db/migrate/*.rb")

      puts "Schema locked successfully!"
    end
  end

end

def run(cmd)
  puts "\033[01;32m    %{command}    \033[00m" % { command: cmd }
  `#{cmd}`
end


RssReader::Application.load_tasks
