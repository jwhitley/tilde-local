#!/usr/bin/env ruby

class String
  def unindent
    gsub /^#{self[/\A\s*/]}/, ''
  end
end

class FIXApp
  USAGE = <<-EOM.unindent
  Usage: #{self.class.name[0...-3]} [options]
    FIX_DESCRIPTION
  EOM

  def initialize(args)
    opts = OptionParser.new do |opts|
      opts.banner = USAGE
      
      opts.on("-f","--fix-me", "Dummy option") do |fix|
        @fix = fix
      end
    end
    
    opts.parse!(args)    
  end

  def run
    FIX_DO_STUFF
  end
end

FIXApp.new(ARGV).run
