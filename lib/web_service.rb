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
    @@api_id = '7d8daxqqj3cd'
end