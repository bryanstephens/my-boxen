class people::bryanstephens::fonts {
  require people::bryanstephens::config

  # Inconsolata-g
  font { "Inconsolata-g": }

  # Source Sans Pro
  font { "SourceSansPro-Black": }
  font { "SourceSansPro-BlackIt": }
  font { "SourceSansPro-Bold": }
  font { "SourceSansPro-ExtraLight": }
  font { "SourceSansPro-ExtraLightIt": }
  font { "SourceSansPro-It": }
  font { "SourceSansPro-Light": }
  font { "SourceSansPro-LightIt": }
  font { "SourceSansPro-Regular": }
  font { "SourceSansPro-Semibold": }
  font { "SourceSansPro-SemiboldIt": }

  file { $people::bryanstephens::config::fonts_dir:
    ensure    => directory,
    owner     => $::boxen_user,
    group     => staff,
    mode      => 0700,
  }

  # This should be somewhere else. Maybe make it more robust and move
  # to boxen/puppet-osx.
  define font ($font = $title, $format = 'otf') {
    $file_name = "${font}.${format}"

    file { "${people::bryanstephens::config::fonts_dir}/${file_name}":
      ensure  => present,
      owner   => $::boxen_user,
      group   => staff,
      mode    => 0644,
      source  => "puppet:///modules/people/bryanstephens/fonts/${file_name}",
      require => File[$people::bryanstephens::config::fonts_dir],
    }
  }
}
