module Retcon
  class BackupServers
    def self.update_disk_space
      BackupServer.all.each do | backup_server |
        backup_server.update_disk_space
      end
    end
    
    def self.queue_backups
      BackupServer.all.each do | backup_server |
        backup_server.queue_backups
      end
    end
    
    def self.start_queued
      BackupServer.all.each do | backup_server |
        backup_server.start_queued
      end
    end
  end
end