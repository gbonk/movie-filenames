
### Process a where a single file has been downloaded



### My Files
require 'title'

module Root
  class File


    def self.process( file )

      filename = file.to_s
      movie_name = ""

      file_type = Util::Filename.get_file_type(filename)

      p "Processing File: " + filename

      result = Util::Filename.process( filename )

      p "----> " + result + "." + file_type.to_s

      #Check first if there is a directory

      # Create a direcoty for it

      # Move the file into the dir

    end







  end
end
