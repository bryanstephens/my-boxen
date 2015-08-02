class people::bryanstephens::config::shell {
  require people::bryanstephens::config

  include zsh

  # dotfiles
  repository { $people::bryanstephens::config::dotfiles_dir:
    source => "${::github_login}/dotfiles",
    require => File[$people::bryanstephens::config::my_dir],
  }

  exec { "install dotfiles":
    provider => shell,
    command  => "./script/install",
    cwd      => $people::bryanstephens::config::dotfiles_dir,
    creates  => "${people::bryanstephens::config::home_dir}/.zshrc",
    require  => Repository[$people::bryanstephens::config::dotfiles_dir],
  }

  # Boxen resource over-rides: stay away from my dotfiles. kthxbai
  File <| title == "${people::bryanstephens::config::home_dir}/.gemrc" |> {
    ensure  => present,
    source  => undef,
  }

  Git::Config::Global <| title == "core.excludesfile" |> {
    value   => undef,
  }

  Git::Config::Global <| title == "credential.helper" |> {
    value   => undef,
  }

}
