#!/usr/bin/env ruby

unless Config::CONFIG["target_os"] =~ /^mswin32/
  $stderr.puts "This script can only run on MS Windows."
  exit 1
end

require 'win32/registry'

module P4
  class << self
    def user
      ENV['P4USER']
    end

    # Manipulate the user's Perforce registry settings
    def with_reg(mode=Win32::Registry::KEY_READ,&block)
      Win32::Registry::HKEY_CURRENT_USER.open('Software\Perforce\Environment',mode,&block)
    end

    def user_clients
      @cached_user_clients ||= `p4 clients -u #{user} | cut -d' ' -f 2`.split("\n").sort
    end

  end # << self
end


if $0 == __FILE__
  usage = <<EOM
Usage: p4reg <client>

Change the current Perforce client as recorded in the Windows registry.
EOM

  if ARGV.length != 1
    $stderr.puts usage
    exit 1
  end
  client = ARGV[0]

  unless P4.user_clients.include?(client)
    $stderr.puts "Unknown client #{client} for user #{P4.user}, valid clients are:"
    $stderr.puts "#{P4.user_clients.inject("") { |s,c| s << "  #{c}\n"} }"
    exit 1
  end

  P4.with_reg(Win32::Registry::KEY_WRITE) do |reg|
    reg.write_s('P4CLIENT',client)
  end
end
