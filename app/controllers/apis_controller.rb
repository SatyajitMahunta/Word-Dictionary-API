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
    
    sha_api = Digest::SHA2.hexdigest Time.now.inspect 
    userid = Current.user.id # Current User's ID
    count = 0

    @api = Api.new({apikey: sha_api , userid: userid, count: count});

    # respond_to do |format|
      if @api.save
        # format.html { redirect_to @api, notice: "Api was successfully created." }
        render :json =>  {  status: :created, location: @api }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /apis/1 or /apis/1.json
  def destroy
    @api.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Api was successfully destroyed." }
      #format.json { head :no_content }
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
