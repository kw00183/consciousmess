class RipplesController < ApplicationController
  include ActionController::Helpers

  before_action :set_ripple, only: %i[ show update ]
  before_action :restrict_destroy_edit, only: [:edit, :destroy]

  helper_method :set_max_range_id
  helper_method :set_min_range_id
  helper_method :maximum_ripple_id
  helper_method :newest
  helper_method :previous
  helper_method :next
  helper_method :oldest

  RIPPLES_MAX = 10

  def inititialize
    self.maximum_ripple_index_id
  end

  def set_max_range_id(id)
    session[:max_ripple_id] = id
  end

  def set_min_range_id(id)
    session[:min_ripple_id] = id
  end

  def reset_session
    session.clear
  end

  # GET /ripples or /ripples.json
  def index
    @ripples = Ripple.all.where(id: session[:min_ripple_id]..session[:max_ripple_id]).order("created_at DESC").limit(RIPPLES_MAX)
  end

  # GET /ripples/1 or /ripples/1.json
  def show
  end

  def maximum_ripple_index_id
    maximum_ripple_index_id = Ripple.maximum("id")
  end

  def newest
    @minimum_range_id = 0
    @maximum_range_id = maximum_ripple_index_id
    if maximum_ripple_index_id - 9 < 1
      @minimum_range_id = maximum_ripple_index_id - 9
    end
    set_min_range_id(@minimum_range_id)
    set_max_range_id(@maximum_range_id)
    redirect_to ripples_path
  end

  def previous
    if session[:max_ripple_id] + 10 > maximum_ripple_index_id
      @maximum_range_id = maximum_ripple_index_id
    else
      @maximum_range_id = session[:max_ripple_id] + 10
    end
    @minimum_range_id = @maximum_range_id - 9
    set_min_range_id(@minimum_range_id)
    set_max_range_id(@maximum_range_id)
    redirect_to ripples_path
  end

  def next
    if session[:max_ripple_id] - 10 >= 1
      @maximum_range_id = session[:max_ripple_id] - 10
    else
      @maximum_range_id = 1
    end

    if @maximum_range_id - 9 >= 1
      @minimum_range_id = @maximum_range_id - 9
    else
      @minimum_range_id = 1
    end
    @minimum_range_id = @maximum_range_id - 9
    set_min_range_id(@minimum_range_id)
    set_max_range_id(@maximum_range_id)
    redirect_to ripples_path
  end

  def oldest
    @minimum_range_id = 0
    if maximum_ripple_index_id < 8
      @maximum_range_id = @maximum_ripple_index_id
    else
      @maximum_range_id = (maximum_ripple_index_id / 10) - 1
    end
    set_min_range_id(@minimum_range_id)
    set_max_range_id(@maximum_range_id)
    redirect_to ripples_path
  end

  # GET /ripples/new
  def new
    @ripple = Ripple.new
  end

  # GET /ripples/1/edit
  def edit
  end

  # POST /ripples or /ripples.json
  def create
    @ripple = Ripple.new(ripple_params)

    respond_to do |format|
      if @ripple.save
        format.html { redirect_to ripples_path, notice: "Ripple was successfully created." }
        format.json { render :show, status: :created, location: @ripple }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ripple.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ripples/1 or /ripples/1.json
  def update
    respond_to do |format|
      if @ripple.update(ripple_params)
        format.html { redirect_to ripple_url(@ripple), notice: "Ripple was successfully updated." }
        format.json { render :show, status: :ok, location: @ripple }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ripple.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ripples/1 or /ripples/1.json
  def destroy
    @ripple.destroy

    respond_to do |format|
      format.html { redirect_to ripples_url, notice: "Ripple was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ripple
      @ripple = Ripple.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ripple_params
      params.require(:ripple).permit(:name, :url, :message)
    end
end
