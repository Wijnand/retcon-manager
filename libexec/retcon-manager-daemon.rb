# Change this file to be a wrapper around your daemon code.

# Do your post daemonization configuration here
# At minimum you need just the first line (without the block), or a lot
# of strange things might start happening...
DaemonKit::Application.running! do |config|
  # Trap signals with blocks or procs
  config.trap( 'INT' ) do
    puts 'going down'
    exit
  end
  config.trap( 'TERM', Proc.new { puts 'Going down'; exit } )
end

def load_mapper_opts
  YAML::load(ERB.new(IO.read(RAILS_ROOT+"/config/nanite/mapper.yml")).result)[DAEMON_ENV || "development"]
end

# Sample loop to show process
EM.run do
  
  opts = load_mapper_opts
  opts.merge!(:offline_failsafe => true)
  $stderr.puts "Starting Nanite mapper..."
  Nanite.start_mapper(opts)
  
  EventMachine::add_periodic_timer 600 do
    Retcon::BackupServers.update_disk_space
  end
  
  EventMachine::add_periodic_timer 60 do
    Retcon::BackupServers.queue_backups
  end
  
  EventMachine::add_periodic_timer 60 do
    Retcon::BackupServers.start_queued
  end
end
