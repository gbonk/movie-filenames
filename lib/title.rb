



require 'facets/string/titlecase'
require 'rest-client'
require 'json'

module Util
  class Filename


    def self.process( file )

      existing_title = ""
      filename = file.basename.to_s

      existing_year = find_year( filename )

      if (! existing_year.nil?)
        existing_title = filename.partition(existing_year).first
      else
        existing_title = filename
      end

#      movie_name =  movie_name.gsub("."," ").titlecase.gsub(" To "," to ").gsub("(","").gsub(" At "," at ").gsub(" Of "," of ").gsub(" On "," on ").gsub(" By "," by ").gsub(" A "," a ").gsub(" An "," an ").gsub(" The "," the ").gsub(" And "," and ").gsub(" But "," but ").gsub(" For "," for ").gsub(" Or "," or ")


      title, year = omdb_exact_match( existing_title, existing_year )

      if title.nil?
        title, year = omdb_search( existing_title, existing_year )
      end


      if (title.nil?)
        return "Error no results found"
      end

      new_folder_name = title + " ("+ year +")"

      if filename != new_folder_name
        puts "Renaming to " + new_folder_name
        file.rename (file.dirname.to_s + "/" + new_folder_name)
      else
        puts "Names Match. Nothing to do"
      end

    end

    def self.find_year( filename )

      return filename.to_s[/\b(?:19|20)\d{2}\b/]

    end

    def self.omdb_exact_match( title, year )

  #    http://www.omdbapi.com/?t=Phantom.of.the.Opera.&y=1943&apikey=def997d7


      response = RestClient.get 'http://www.omdbapi.com/', {:params => { :t => title, :y => year, :apikey => 'def997d7'}}

      body = JSON.parse(response.body)

      response = body["Response"]

      if response == "False"
        puts "Error lookup by title and year failed"
        puts "Title:  " +  title.to_s
        puts "Year:  " + year.to_s

        return
      end

      return body["Title"], body["Year"]

    end

    def self.omdb_search( title, year )

  #    http://www.omdbapi.com/?t=Phantom.of.the.Opera.&y=1943&apikey=def997d7


      response = RestClient.get 'http://www.omdbapi.com/', {:params => { :s => title, :y => year, :apikey => 'def997d7'}}

      body = JSON.parse(response.body)

      response = body["Response"]

      if response == "False"
        puts "Error search failed"
        return
      end

      return body[0]["Title"], body[0]["Year"]


    end




    def self.is_final_format( filename )

        return filename[/\A[a-zA-z ]*\((?:19|20)\d{2}\)/]

    end


  end
end
