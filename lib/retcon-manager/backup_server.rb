module Retcon
  class BackupServers
    def self.update_disk_space
      BackupServer.all.each do | backup_server |
        backup_server.update_disk_space
      end
    end
  end
end