# Bootstrap the Rails environment, frameworks, and default configuration
#require File.join(File.dirname(__FILE__), '..','..','..','retcon-web', 'config', 'environment')
RAILS_ROOT = File.join(File.dirname(__FILE__), '..','..','..','retcon-web')

$: << RAILS_ROOT

ENV["RAILS_ENV"] ||= "development"
ENV["NO_NM"] = "1"

require RAILS_ROOT + "/config/environment"
