### Sys Libs
require 'pathname.rb'


### My Libs
require 'title'

module Root
  class Folder


    def self.process( folder )

      foldername = folder.basename
      movie_name = ""

      p "Processing Folder: " + foldername.to_s

# What should this folder be renamed to ?
      new_folder_name = Util::Filename.process( foldername )

# Loop through this folder's contents
      folder.children.each do |item|
        next if item == '.' or item == '..'

        if item.directory?
          Sub::Folder.process(item)
        elsif item.file?
          Sub::File.process(item)
        else
          p "Error of somesort. Shouldn't be here.  Item is not a directory or file:  " + item.class.to_s
        end
      end
# Easy Cases of things to filter out....



    end

  end
end


#Inteligently process or remove any subfolders from a root folder
module Sub
  class File


    def self.process( file )

      filename = file.basename.to_s

      # Some files we never care about, just delete them
      if just_delete(file)
         return
      end

      if false
      elsif file.to_s =~ /sample:/i
        p "Deleting: " + filename
      else
        p "Ignoring: " + filename
      end

    end

    def self.just_delete(file)

      file_types_we_want = ["mkv", "avi", "mov", "mp4", "wmf", "m4p", "m4v", "mpv", "srt"]

      if ! file_types_we_want.include? file.extname
        p "OK to delete?  " + filename
        input = gets
        if input.start_with? "y"
          file.delete
          return true
        else
          puts "....skipping"
          return false
        end
      end
    end

  end
end


#Inteligently process or remove any subfolders from a root folder
module Sub
  class Folder


    def self.process( folder )

      is_subtitle_folder

      foldername = folder.basename.to_s
      movie_name = ""

      p "Processing Sub-Folder: " + foldername

    end

  end
end
