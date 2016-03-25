class BulbsController < ApplicationController
  before_action :set_bulb, only: [:show, :edit, :update, :destroy]

  # GET /bulbs
  # GET /bulbs.json
  def index
    @bulbs = Bulb.all
  end

  # GET /bulbs/1
  # GET /bulbs/1.json
  def show
  end

  # GET /bulbs/new
  def new
    @bulb = Bulb.new
  end

  # GET /bulbs/1/edit
  def edit
  end

  # POST /bulbs
  # POST /bulbs.json
  def create
    @bulb = Bulb.new(bulb_params)
    search_results = Unsplash::Photo.search(@bulb.target)
      if search_results.count != 0
        @bulb.picture = search_results.sample.urls["small"]
      end

    respond_to do |format|
      if @bulb.save
        format.html { redirect_to bulbs_url }
        format.json { render :show, status: :created, location: @bulb }
      else
        format.html { render :new }
        format.json { render json: @bulb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulbs/1
  # PATCH/PUT /bulbs/1.json
  def update
    respond_to do |format|
      if @bulb.update(bulb_params)
        format.html { redirect_to @bulb, notice: 'Bulb was successfully updated.' }
        format.json { render :show, status: :ok, location: @bulb }
      else
        format.html { render :edit }
        format.json { render json: @bulb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulbs/1
  # DELETE /bulbs/1.json
  def destroy
    @bulb.destroy
    respond_to do |format|
      format.html { redirect_to bulbs_url, notice: 'Bulb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulb
      @bulb = Bulb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulb_params
      params.require(:bulb).permit(:user_id, :title, :what, :forwhom, :why, :need, :category, :private, :target, :verb, :description, :art)
    end
end
