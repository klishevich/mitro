require 'resque/tasks'
# require Rails.root.join('app/workers/update_clients_bonus.rb').to_s

task "resque:setup" => :environment do
	ENV['QUEUE'] = '*'
end