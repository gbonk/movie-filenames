



require 'facets/string/titlecase'


module Util
  class Filename


    def self.process( filename )

      movie_name = ""

      year = find_year( filename )

      if (! year.nil?)
        movie_name = filename.partition(year).first
      end

      movie_name =  movie_name.gsub("."," ").titlecase.gsub(" To "," to ").gsub("(","").gsub(" At "," at ").gsub(" Of "," of ").gsub(" On "," on ").gsub(" By "," by ").gsub(" A "," a ").gsub(" An "," an ").gsub(" The "," the ").gsub(" And "," and ").gsub(" But "," but ").gsub(" For "," for ").gsub(" Or "," or ")

      if (! year.nil?)
        return movie_name + "("+ year +")"
      else
        return movie_name

      end
    end

    def self.find_year( filename )

      return filename[/\b(?:19|20)\d{2}\b/]

    end

    def self.get_file_type( filename )

        return filename.split('.').last

    end



  end
end
