require 'digest'

class ApisController < ApplicationController
  before_action :set_api, only: %i[ show edit update destroy ]

  
  # GET /apis or /apis.json
  def index
    @apis = Api.all
  end

  # GET /apis/new
  def new
    @api = Api.new
  end


  # POST /apis or /apis.json
  def create
    # puts "HELLO HELLO HELLO HELLO HELLO"
    # puts Current.user
    @userid = Current.user.id
    @user = User.find_by(id: @userid)
    @curr_api_cnt = @user["api_cnt"]
    @curr_plan_type = @user["plan_type"]
    if (@curr_plan_type == 1 && @curr_api_cnt == 5) || (@curr_plan_type == 2 && @curr_api_cnt == 10)  
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You have reached the API_key generation limit, Kindly Choose Plan_Type 3 for more API Keys." }
      end
      return
    end
    sha_api = Digest::SHA2.hexdigest Time.now.inspect 
     # Current User's ID
    count = 0
    
    User.update( @userid , :api_cnt => @curr_api_cnt + 1)

    @api = Api.new({apikey: sha_api , userid: @userid, count: count});

    respond_to do |format|
      if @api.save
        format.html { redirect_to root_path, notice: "Api was successfully created." }
        #render :json =>  {  status: :created, location: @api }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apis/1 or /apis/1.json
  def destroy
    @userid = Current.user.id
    @user = User.find_by(id: @userid)
    @curr_api_cnt = @user["api_cnt"]
    User.update( @userid , :api_cnt => @curr_api_cnt - 1)
    @api.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Api Destroyed Successfully." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api
      @api = Api.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_params
      params.require(:api).permit(:apikey, :userid, :count)
    end
end
