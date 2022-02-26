class RipplesController < ApplicationController
  include ActionController::Helpers

  before_action :set_ripple, only: %i[ show update ]
  before_action :restrict_destroy_edit, only: [:edit, :destroy]

  helper_method :set_page_number
  helper_method :index_offset
  helper_method :reset_session
  helper_method :maximum_ripple_id
  helper_method :maximum_page_number
  helper_method :newest
  helper_method :previous
  helper_method :next
  helper_method :oldest

  RIPPLES_MAX = 10

  def inititialize
    session[:page_number] = Hash.new
    self.maximum_ripple_id
    self.maximum_page_number
    self.page_number(0)

    @ripple_offset = maximum_ripple_id
  end

  def set_page_number(page_number)
    session[:page_number] = page_number
  end

  def reset_session
    session.clear
  end

  # GET /ripples or /ripples.json
  def index
    self.index_offset(@ripple_offset)
    @ripples = @ripples
  end

  def index_offset(ripple_offset)
    @ripple_offset = ripple_offset
    @ripples = Ripple.all.order("id DESC").offset(@ripple_offset).limit(RIPPLES_MAX)
  end

  # GET /ripples/1 or /ripples/1.json
  def show
  end

  def maximum_ripple_id
    maximum_ripple_id = Ripple.maximum("id")
  end

  def maximum_page_number
    if maximum_ripple_id % 10
      maximum_page_number = maximum_ripple_id / 10
    else
      maximum_page_number = (maximum_ripple_id/ 10) - 1
    end
  end

  def newest
    page_number = 0
    self.set_page_number(0)
    self.index_offset(@maximum_ripple_id)
    render :index
  end

  def previous
    page_number = session[:page_number]

    if page_number > 0
      previous_page = page_number - 1
      self.set_page_number(previous_page)
      @ripple_offset = previous_page * RIPPLES_MAX
      self.index_offset(@ripple_offset)
      render :index
    end
  end

  def next
    page_number = session[:page_number]

    if page_number < maximum_page_number
      next_page = page_number + 1
      self.set_page_number(next_page)
      @ripple_offset = next_page * RIPPLES_MAX
      self.index_offset(@ripple_offset)
      render :index
    end
  end

  def oldest
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
