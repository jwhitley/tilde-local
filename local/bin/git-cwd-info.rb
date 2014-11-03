#!/usr/bin/ruby
# -*- coding: utf-8 -*-

# Emits Git metadata for use in a Zsh prompt.
#
# AUTHOR:
#    Ben Hoskings
#   https://github.com/benhoskings/dot-files/blob/master/files/bin/git_cwd_info
#
# MODIFIED:
#    Geoffrey Grosenbach http://peepcode.com

# The methods that get called more than once are memoized.

module XTerm
  CSI = "\e["   # Control Sequence Introducer

  module Character
    Black   = 0
    Red     = 1
    Green   = 2
    Yellow  = 3
    Blue    = 4
    Magenta = 5
    Cyan    = 6
    White   = 7
    DEFAULT = 9

    def fg_lo(color)
      "#{CSI}3#{color}m"
    end

    def bg_lo(color)
      "#{CSI}4#{color}m"
    end

    def fg_hi(color)
      "#{CSI}9#{color}m"
    end

    def bg_hi(color)
      "#{CSI}10#{color}m"
    end

    def reset
      "#{CSI}0m"
    end
  end
end

module Prompt
  module Zsh
    # quote escape codes for zsh prompt
    def q(esc_codes)
      "%{#{esc_codes}%}"
    end
  end

  module Git
    include Prompt::Zsh
    include XTerm
    include XTerm::Character

    extend self

    def repo_path
      @git_repo_path ||= `git rev-parse --git-dir 2>/dev/null`.strip
    end

    def in_repo
      !repo_path.empty?
    end

    def parse_branch
      @git_parse_branch ||= `git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||'`.chomp
    end

    def head_commit_id
      `git rev-parse --short HEAD 2>/dev/null`.strip
    end

    def clean?
      @got_clean ||= (repo_path == '.' || `git status --porcelain`.strip.empty?)
    end

    def cwd_dirty
      " #{q fg_hi(Black)}✗#{q reset}" unless clean?
    end

    def rebasing_etc
      if File.exists?(File.join(repo_path, 'BISECT_LOG'))
        "+bisect"
      elsif File.exists?(File.join(repo_path, 'MERGE_HEAD'))
        "+merge"
      elsif %w[rebase rebase-apply rebase-merge ../.dotest].any? {|d| File.exists?(File.join(repo_path, d)) }
        "+rebase"
      end
    end

    def branch_color
      if clean?
        fg_hi(Black)
      else
        fg_hi(Red)
      end
    end

    def prompt
      print "#{q branch_color}#{parse_branch} #{q fg_lo(White)}#{head_commit_id}#{q reset}#{rebasing_etc}"
    end
  end
end

if Prompt::Git.in_repo
  Prompt::Git.prompt
end

