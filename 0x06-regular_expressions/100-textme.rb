#!/usr/bin/env ruby
puts ARGV[0].scan(/(form|to|flags):(.*?)\]/).join(",")
