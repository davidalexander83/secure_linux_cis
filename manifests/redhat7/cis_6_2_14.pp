# 6.2.14 Ensure no users have .rhosts files (Scored)
#
#
# Description:
# While no .rhosts files are shipped by default, users can easily create them.
#
# @summary 6.2.14 Ensure no users have .rhosts files (Scored)
#
# @example
#   include secure_linux_cis::redhat7::cis_6_2_14
  class secure_linux_cis::redhat7::cis_6_2_14 (
  Boolean $enforced = true,
) {

  if $enforced {

    file { '/tmp/cis_scripts/rhost.sh':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0711',
      source => 'puppet:///modules/secure_linux_cis/rhost.sh',
    }

    if $facts[ 'rhost_files' ] {
      notify { 'rf':
        message  => '[6.2.14] A user(s) has .rhost files in their home directory. Check the rhost_files fact for details',
        loglevel => 'warning',
      }
    }
  }
}
