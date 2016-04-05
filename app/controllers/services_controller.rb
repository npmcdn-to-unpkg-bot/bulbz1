class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    @service.save

    @bulb = Bulb.new
    @bulb.title = params[:service][:title]
    @bulb.description = params[:service][:description]
    @bulb.target = params[:service][:target]
    @bulb.category = "service"
    @bulb.ref_id = @service.id
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
        @service.picture = @bulb.picture
        @service.save
    end

    respond_to do |format|
      if @service.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :target, :description, :picture, :big_picture)
    end
end
