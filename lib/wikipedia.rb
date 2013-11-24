class Wikipedia
    def self.find_artist(artist)
        require 'uri'
        #base_url = 'http://en.wikipedia.org/w/api.php?format=json&action=query&titles='+artist+'&prop=revisions&rvprop=content'

        encoded = artist.gsub(' ', '_')
        base_url = 'http://en.wikipedia.org/wiki/'+encoded

        response = Typhoeus.get(base_url).body
        start_index = response.index('</table>')
        end_index = response.index('</p>')
        result = response.slice(start_index, (end_index-start_index))
    end
end