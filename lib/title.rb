



require 'facets/string/titlecase'
require 'rest-client'
require 'json'

module Util
  class Filename


    def self.process( filename )

      title = filename.basename.to_s

      year = find_year( filename )

      if (! year.nil?)
        title = title.partition(year).first
      end

#      movie_name =  movie_name.gsub("."," ").titlecase.gsub(" To "," to ").gsub("(","").gsub(" At "," at ").gsub(" Of "," of ").gsub(" On "," on ").gsub(" By "," by ").gsub(" A "," a ").gsub(" An "," an ").gsub(" The "," the ").gsub(" And "," and ").gsub(" But "," but ").gsub(" For "," for ").gsub(" Or "," or ")


      call_omdb( title, year )

      exit(0);

      if (! year.nil?)
        return title + "("+ year +")"
      else
        return title

      end
    end

    def self.find_year( filename )

      return filename.to_s[/\b(?:19|20)\d{2}\b/]

    end

    def self.get_file_type( filename )

        return filename.split('.').last

    end

    def self.call_omdb( title, year )

  #    http://www.omdbapi.com/?t=Phantom.of.the.Opera.&y=1943&apikey=def997d7


      response = RestClient.get 'http://www.omdbapi.com/', {:params => { :t => title, :y => year, :apikey => 'def997d7'}}

      body = JSON.parse(response.body)

      puts body["Title"]

    end




    def self.is_final_format( filename )

        return filename[/\A[a-zA-z ]*\((?:19|20)\d{2}\)/]

    end


  end
end
