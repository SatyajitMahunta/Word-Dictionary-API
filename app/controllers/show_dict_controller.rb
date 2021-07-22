class ShowDictController < ApplicationController
   
    def show
        @word_name = params[:word]
        @operation_type = params[:type]
        @api_key = params[:API_KEY]
        # Check API Key is Present or not
        if Api.exists?(apikey: @api_key)
            @data = Dictionary.find_by(word: @word_name)
            render :json => @data["data"][@operation_type]
        else
            render :json => {status: "WRONG API KEY :( " }
        end        
    end 
    
end    