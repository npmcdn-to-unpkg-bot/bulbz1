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
    @bulb.save

    respond_to do |format|
      if @platform.save
        format.html { redirect_to platforms_url }
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
    respond_to do |format|
      if @platform.update(platform_params)
        format.html { redirect_to @platform, notice: 'Platform was successfully updated.' }
        format.json { render :show, status: :ok, location: @platform }
      else
        format.html { render :edit }
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
      params.require(:platform).permit(:title, :target1, :target2, :description, :gain1, :gain2, :picture)
    end
end
