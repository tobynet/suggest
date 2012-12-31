#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'open-uri'
require "json"

# implements
module GoogleSuggest
  class << self
    API_URI = 'https://clients1.google.co.jp/complete/search?client=hp&hl=ja&ie=UTF-8&oe=UTF-8&q=%s'
    def suggest(text)
      # send query
      # support proxy with HTTP_PROXY environment by default open-uri
      response = URI(URI.encode(API_URI % text)).read
      obj = JSON.parse(response.sub(/^[^\(]+\((.+)\)$/, '\1'))
      obj.shift
      return obj.first.map(&:first)
    end
  end
end

# run script if possible
case $PROGRAM_NAME
# write script
when __FILE__
  # Parse options
  require 'optparse'
  program_name = File.basename(__FILE__)
  opt = OptionParser.new do |opts|
    opts.banner = "GoogleSuggest: suggest word"
    opts.define_head "Usage: #{program_name} text"
    opts.separator <<-EOD
Examples:
  $ #{program_name} fuba
  フバーハ
  不買運動
  不買リスト
  不買運動 韓国
  不買運動 リスト
  不買運動 花王
  fubar
  fubar 福岡
  文箱
  付番

Options:
    EOD

    opts.on("-s", "--sample", "Run sample code as usage or examples") do |v|
      cmd = "#{program_name} fuba"
      puts "$ #{cmd}"
      system(*cmd.split)
      exit
    end

    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
    end
  end
  opt.parse!

  if ARGV.empty?
    puts opt
    exit
  end

  # run each args
  ARGV.each{|f| puts GoogleSuggest.suggest(f) }

# write spec
when /rspec$/
  describe GoogleSuggest do
    it ".suggest" do
      result = GoogleSuggest.suggest("くろ")
      result.should include("クロネコヤマト")
      result.should_not include("不買運動")
    end
  end
end
