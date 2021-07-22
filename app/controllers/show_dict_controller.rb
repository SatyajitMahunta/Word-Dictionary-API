class ShowDictController < ApplicationController
   
    def show
        @word_name = params[:word]
        @operation_type = params[:type]
        @api_key = params[:API_KEY]
        # Check API Key is Present or not
        if Api.exists?(apikey: @api_key)
            # Check API is eligible for the service or not
            @user_id = Api.find_by(api_key: @api_key)["userid"] 
            @user_ = User.find_by(id: @user_id)
            @user_type = @user["plan_type"]
            @user_usage = @user["usage"]
            # userid of api
            # user's type
            # user's usage 
                 # 3 
                    # go on
                 # 2 && usage < 500
                   # go on
                 # 1 && usage < 1000
                   # go on
                 # else
                   # FUCK OFF        
            @data = Dictionary.find_by(word: @word_name)
            
            render :json => @data["data"][@operation_type]
        else
            render :json => {status: "WRONG API KEY :( " }
        end        
    end 

end    