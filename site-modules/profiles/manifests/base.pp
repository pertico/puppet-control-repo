# Class: profiles::base
#
# Base configuration
# 
class profiles::base {
  include timezone
  include apt
  include profiles::base::systemd_resolved
}
