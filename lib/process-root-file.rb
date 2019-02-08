
### Process a where a single file has been downloaded



### My Files
require 'title'

module Root
  class File


    def self.process( file )

      filename = file.basename.to_s
      movie_name = ""

      file_type = file.extname

      p "Processing File: " + filename

      result = Util::Filename.process( file )

      p "----> " + result + "." + file_type.to_s

      #Check first if there is a directory

      # Create a direcoty for it

      # Move the file into the dir

    end







  end
end
