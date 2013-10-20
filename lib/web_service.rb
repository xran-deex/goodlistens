class WebService
    def self.find_artist(artist)

        result = Typhoeus.get("http://api.7digital.com/1.2/artist/search", 
            params: {   
                q: artist, country: 'US', oauth_consumer_key: @@api_id
            }
        )
        artist_xml = Hash.from_xml(result.body)
        artist_id = artist_xml['response']['searchResults']['searchResult'][0]['artist']['id']
        result = Typhoeus.get("http://api.7digital.com/1.2/artist/releases",
            params: {
                artistid: artist_id, country: 'US', oauth_consumer_key: @@api_id, pageSize: '100'
            }
        )
        Hash.from_xml(result.body)
    end

    def self.cache_artist(genre)
        result = Typhoeus.get("http://api.7digital.com/1.2/artist/bytag/top", 
            params: {   
                country: 'US', oauth_consumer_key: @@api_id, tags: genre, pageSize: '500', page: '4'
            }
        )
        artist_xml = Hash.from_xml(result.body)
        #return artist_xml
        @artists = []
        artist_xml['response']['taggedResults']['taggedItem'].each do |a|
            artist = Artist.new
            artist.name = a['artist']['name']
            artist.artist_id = (a['artist']['id']).to_i
            #artist.url = a['url']
            artist.image = a['artist']['image']
            artist.popularity = (a['artist']['popularity']).to_f
            artist.save
            #@artists << a
        end
        #@artists
    end

    def self.cache_albums
        result = Typhoeus.get("http://api.7digital.com/1.2/release/bydate", 
            params: {   
                country: 'US', oauth_consumer_key: @@api_id, pageSize: '500', page: '2'
            }
        )
        artist_xml = Hash.from_xml(result.body)
        #return artist_xml
        @artists = []
        artist_xml['response']['releases']['release'].each do |a|
            r = Album.new
            r.album_id = (a['id']).to_i
            r.title = a['title']
            r.artist_id = (a['artist']['id']).to_i
            r.release_date = a['releaseDate'].to_time
            r.image = a['image']
            r.year = a['year']
            r.track_count = (a['trackCount']).to_i
            r.popularity = (a['popularity']).to_f
            r.save
            #@artists << a
        end
        #@artists
    end

    @@api_id = '7d8daxqqj3cd'
end