class DictionaryController < ApplicationController
    
    def new
        @dictionary = Dictionary.new
    end
    
    # POST /products or /products.json
    def create
        if Dictionary.first == nil
            @@dic_data = File.read("C:\\Users\\91754\\Desktop\\Ruby_On_Rails_Projects\\word_dict\\public\\dictionary.json")
            response = JSON.parse(@@dic_data)
            response.each { |key, value| Dictionary.create!(word: key, data: value) }
        end
    end
    
    # private
    # # Only allow a list of trusted parameters through.
    # def word_params
    #   params.require(:dictionary).permit(:word, :data)
    # end
end    