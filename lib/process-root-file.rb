
### Process a where a single file has been downloaded

require 'facets/string/titlecase'

module Root
  class File


    def self.process( file )

      filename = file.to_s
      movie_name = ""

      p "Processing File: " + filename


      year = find_year( filename )

      if (! year.nil?)
        movie_name = filename.partition(year).first
      end

      movie_name =  movie_name.gsub("."," ").titlecase.gsub(" To "," to ").gsub(" At "," at ").gsub(" Of "," of ").gsub(" On "," on ").gsub(" By "," by ").gsub(" A "," a ").gsub(" An "," an ").gsub(" The "," the ").gsub(" And "," and ").gsub(" But "," but ").gsub(" For "," for ").gsub(" Or "," or ")

      if (! year.nil?)
        p "---> " + movie_name + "("+ year +")"
      else
        p "---> " + movie_name

      end
    end

    def self.find_year( filename )

      return filename[/\b(?:19|20)\d{2}\b/]

    end





  end
end
