class PlatformsController < ApplicationController
  before_action :set_platform, only: [:show, :edit, :update, :destroy]

  # GET /platforms
  # GET /platforms.json
  def index
    @platforms = Platform.all
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
  end

  # GET /platforms/new
  def new
    @platform = Platform.new
  end

  # GET /platforms/1/edit
  def edit
  end

  # POST /platforms
  # POST /platforms.json
  def create
    @platform = Platform.new(platform_params)
    @platform.save

    @bulb = Bulb.new
    @bulb.title = params[:platform][:title]
    @bulb.description = params[:platform][:description]
    @bulb.target1 = params[:platform][:target1]
    @bulb.target2 = params[:platform][:target2]
    @bulb.category = "platform"
    @bulb.ref_id = @platform.id
        @bulb.user_id = current_user.id
    @bulb.save

      @platform.bulb_id = @bulb.id
     @platform.save

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
        @platform.picture = @bulb.picture
        @platform.save
    end

    respond_to do |format|
      if @platform.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :created, location: @platform }
      else
        format.html { render :new }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /platforms/1
  # PATCH/PUT /platforms/1.json
  def update

    @platform.update(platform_params)
    @platform.save

    @bulb = Bulb.find_by(:id => @platform.bulb_id)
    @bulb.title = params[:platform][:title]
    @bulb.description = params[:platform][:description]
    @bulb.target1 = params[:platform][:target1]
    @bulb.target2 = params[:platform][:target2]
    @bulb.category = "platform"
    @bulb.ref_id = @platform.id
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
      if @platform.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :created, location: @platform }
      else
        format.html { render :new }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    @platform.destroy
    respond_to do |format|
      format.html { redirect_to platforms_url, notice: 'Platform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform
      @platform = Platform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_params
      params.require(:platform).permit(:title, :target1, :target2, :description, :gain1, :gain2, :picture, :big_picture, :bulb_id)
    end
end
