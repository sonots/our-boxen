class people::sonots {
  include chrome # Puppetfile で定義したもの
  
  # homebrew でインストールするもの
  package {
    [
      'tmux',
      'reattach-to-user-namespace',
      'tree',
      'pidof',
      'ctags',
    ]:
  }

  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  file { $home:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'sonots/.dotfiles',
    require => File[$home]
  }

  exec { "sh ${dotfiles}/install.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }
}
