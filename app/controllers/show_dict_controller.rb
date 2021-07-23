class ShowDictController < ApplicationController
   
    def show
        @word_name = params[:word]
        @operation_type = params[:type]
        @api_key = params[:API_KEY]
        # Check API Key is Present or not
        if Api.exists?(apikey: @api_key)
            # Check API is eligible for the service or not
             @curr_api = Api.find_by(apikey: @api_key)
             @curr_api_id = @curr_api["id"]
             @curr_api_count = @curr_api["count"]

             @curr_user_id = @curr_api["userid"]
             @user = User.find_by(id: @curr_user_id)
             @user_type = @user["plan_type"]
             @user_usage = @user["usage"]
            
            if (@user_type == 3 && @user_usage < 1000) || (@user_type == 2 && @user_usage < 2000) || (@user_type == 1 && @user_usage < 500)
                User.update(@curr_user_id , :usage => @user_usage + 1)
                Api.update(@curr_api["id"] , :count => @curr_api_count + 1)
                render :json => {id: @curr_user_id , type: @user_type , use: @user_usage }
            else
                render :json => {id: "FUCK" }
            end    
                 
            @data = Dictionary.find_by(word: @word_name)
            
            #render :json => @data["data"][@operation_type]
        else
            render :json => {status: "WRONG API KEY :( " }
        end        
    end 

end    