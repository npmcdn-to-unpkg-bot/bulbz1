require "net/http"
require "uri"
require 'json'

class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]

  # GET /apps
  # GET /apps.json
  def index
    @apps = App.all
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create

    @app = App.new(app_params)
    @app.save

    @bulb = Bulb.new
    @bulb.title = params[:app][:title]
    @bulb.description = params[:app][:description]
    @bulb.target = params[:app][:target]
    @bulb.category = "app"
    @bulb.ref_id = @app.id
    @bulb.user_id = current_user.id
    @bulb.save

    @app.bulb_id = @bulb.id
    @app.save

    uri = URI.parse("https://api.monkeylearn.com/v2/extractors/ex_y7BPYzNG/extract/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    # Set POST data
    request.body = {text_list: [@bulb.description]}.to_json
    request.add_field("Content-Type", "application/json")
    request.add_field("Authorization", "token c956c6be34d90185c5eab3c04a8f58416259aa67")
    # parse the monkeylearn respons
    response = JSON.parse http.request(request).body
    response_array = response["result"].first

    keywords = Array.new

    response_array.each do |response|
      keywords << response["keyword"]
    end

    keywords.each do |keyword|
      k = Keyword.new
      k.bulb_id = @bulb.id
      k.content = keyword
      k.save
    end

    picture_results = Unsplash::Photo.search(keywords.sample)
      if picture_results.count != 0
        picture_sample = picture_results.sample
        @bulb.picture = picture_sample.urls["small"]
        @bulb.big_picture = picture_sample.urls["regular"]
        @bulb.save
        @app.picture = @bulb.picture
        @app.save
    end


    respond_to do |format|
      if @app.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :created, location: @app }
      else
        format.html { render :new }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update

    @app.update(app_params)
    @app.save

    @bulb = Bulb.find_by(:id => @app.bulb_id)
    @bulb.title = params[:app][:title]
    @bulb.description = params[:app][:description]
    @bulb.target = params[:app][:target]
    @bulb.category = "app"
    @bulb.ref_id = @app.id
    @bulb.user_id = current_user.id
    @bulb.save


    uri = URI.parse("https://api.monkeylearn.com/v2/extractors/ex_y7BPYzNG/extract/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    # Set POST data
    request.body = {text_list: [@bulb.description]}.to_json
    request.add_field("Content-Type", "application/json")
    request.add_field("Authorization", "token c956c6be34d90185c5eab3c04a8f58416259aa67")
    # parse the monkeylearn respons
    response = JSON.parse http.request(request).body
    response_array = response["result"].first

    keywords = Array.new

    response_array.each do |response|
      keywords << response["keyword"]
    end

    keywords.each do |keyword|
      k = Keyword.new
      k.bulb_id = @bulb.id
      k.content = keyword
      k.save
    end



    respond_to do |format|
      if @app.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :ok, location: @app }
      else
        format.html { render :edit }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url, notice: 'App was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:title, :target, :description, :picture, :big_picture, :bulb_id)
    end
end
