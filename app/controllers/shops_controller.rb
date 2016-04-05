class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)
    @shop.save

    @bulb = Bulb.new
    @bulb.title = params[:shop][:title]
    @bulb.description = params[:shop][:description]
    @bulb.target = params[:shop][:target]
    @bulb.category = "shop"
    @bulb.ref_id = @shop.id
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

    picture_results = Unsplash::Photo.search(keywords.sample)
      if picture_results.count != 0
        picture_sample = picture_results.sample
        @bulb.picture = picture_sample.urls["small"]
        @bulb.big_picture = picture_sample.urls["regular"]
        @bulb.save
        @shop.picture = @bulb.picture
        @shop.save
    end

    respond_to do |format|
      if @shop.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:title, :target, :description, :picture, :big_picture)
    end
end
