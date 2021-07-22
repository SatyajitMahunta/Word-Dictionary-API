class ShowDictController < ApplicationController
   
    def show
        @dog = params[:word]
        @cat = params[:type]
        
        @lion = Dictionary.find_by(word: @dog)
        render :json => @lion["data"][@cat]
    end 

end    