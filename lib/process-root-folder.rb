### Sys Libs
require 'pathname.rb'


### My Libs
require 'title'

module Root
  class Folder


    def self.process( folder )

      foldername = folder.to_s
      movie_name = ""

      p "Processing Folder: " + foldername

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

      filename = file.to_s

      if [".txt", ".nfo"].include? file.extname
        p "Deleting: " + filename
      elsif file.to_s =~ /sample:/i
        p "Deleting: " + filename
      else
        p "Ignoring: " + filename
      end

    end

  end
end


#Inteligently process or remove any subfolders from a root folder
module Sub
  class Folder


    def self.process( folder )

      foldername = folder.to_s
      movie_name = ""

      p "Processing Folder: " + foldername

    end

  end
end
