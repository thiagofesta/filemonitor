#!/usr/bin/env ruby
 
require 'rubygems'
require 'net/scp'
require 'fssm'
require 'colorize'
require 'parseconfig'

$config = ParseConfig.new('./config.rb')

def ssh(ssh_command)
    system "ssh #{$config["username"]}@#{$config["host"]} 'cd #{$config["remote_base_url"]}; #{ssh_command}'"
end

def sendFile(base, file)
    Net::SCP.upload!($config["host"], $config["username"],
        "#{base}/#{file}", "#{$config["remote_base_url"]}/#{file}",
        :password => $config["password"])
end

def deleteFile(file)
    ssh("rm '#{file}'")
end

puts ">>> FileMonitor is polling for changes. Press Ctrl-C to Stop."
 
FSSM.monitor($config["local_base_url"], '**/*', :directories => true) do
    update do |b, r, t|
        if t == :directory
            # do nothing for now I think...
        else
            puts ">> FILE -> UPDATE -> #{r}".colorize( :yellow )
            sendFile(b, r)
        end
    end

    create do |b, r, t|
        if t == :directory
            puts ">> DIR -> CREATE -> #{r}".colorize( :green )
            ssh("mkdir \"#{r}\"")
        else
            puts ">> FILE -> CREATE -> #{r}".colorize( :green )
            sendFile(b, r)
        end
    end
 
    delete do |b, r, t|
        if t == :directory
            puts ">> DIR -> DELETE -> #{r}".colorize( :red )
            ssh("rm -rf \"#{r}\"")
        else
            puts ">> FILE -> DELETE -> #{r}".colorize( :red )
            deleteFile(r)
        end
    end
end