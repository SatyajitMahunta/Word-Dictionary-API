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
                
                @data = Dictionary.find_by(word: @word_name)
                if @word_name == "randomWord"
                    @random_id = rand(1..42)
                    @data = Dictionary.find_by(id: @random_id)
                end    

                if @operation_type == nil
                    render :json => { word: @data["word"] }
                else
                    render :json => @data["data"][@operation_type]
                end    
                #render :json => {id: @curr_user_id , type: @user_type , use: @user_usage }
            else
                render :json => {id: "Something Wrong Happened :( " }
            end    
            #render :json => @data["data"][@operation_type]
        else
            render :json => {status: "WRONG API KEY :( " }
        end        
    end 

end    