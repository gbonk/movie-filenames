#!/usr/bin/env ruby

$LOAD_PATH << "#{File.dirname(__FILE__)}/lib"

### Standard Libs
require 'optparse'
require 'pathname.rb'

### My Files
require 'process-root-file'
require 'process-root-folder'

### If there are no Args default to show the help
ARGV << '--help' if ARGV.empty?

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: scan-files.rb <<directory>>"
end
optparse.parse!

directory = ARGV.pop
raise "Need to specify a file to process" unless directory

root_dir = Pathname.new( directory ).realpath

directories_to_skip = [".", "..", "#recycle", "P R O N", "TODO",]

root_dir.children.each do |item|

   if item.basename.to_s.start_with? *directories_to_skip
     puts "Skipping: " + item.to_s
     next
   end

  if File.directory?(item)
    Root::Folder.process(item)
  elsif File.file?(item)
    Root::File.process(item)
  else
    p "Error of somesort. Shouldn't be here.  Item is not a directory or file:  " + item.class.to_s
  end
end
