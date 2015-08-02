class people::bryanstephens::applications::terminals {
  require people::bryanstephens::config

  include iterm2::dev

  # iTerm 2 preferences
  initialize_plist { "com.googlecode.iterm2": }

  # Terminal.app preferences
  initialize_plist { "com.apple.Terminal": }

  # Initializes a plist from the repository, but does not replace if present.
  define initialize_plist ($identifier = $title) {
    $file  = "${identifier}.plist"
    $plist = "${people::bryanstephens::config::preferences_dir}/${file}"
    $src   = "puppet:///modules/people/bryanstephens/plists/${file}"

    file { $plist:
      ensure    => file,
      owner     => $::boxen_user,
      group     => staff,
      mode      => 0600,
      source    => $src,
      replace   => false,
    }
  }
}
