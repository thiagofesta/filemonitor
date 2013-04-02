# FileMonitor

FileMonitor is a ruby program to monitor files and folder changes and apply those changes to a remote server using SSH and SCP


## Requirements

- Ruby
- Gem module [fssm](https://github.com/ttilley/fssm)
- Gem module [colorize](https://github.com/fazibear/colorize)
- Gem module [win32console](https://github.com/luislavena/win32console)
- Gem module [parseconfig](https://github.com/derks/ruby-parseconfig)
- [net-scp](https://github.com/net-ssh/net-scp)
- SSH on your path

Soon will be replaced the SSH on command line by [net-ssh](https://github.com/net-ssh/net-ssh).

For Windows users I recommend using GitBash env.