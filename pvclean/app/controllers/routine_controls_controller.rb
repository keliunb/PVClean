class RoutineControlsController < ApplicationController
  before_action :set_routine_control, only: [:show, :edit, :update, :destroy]

  # GET /routine_controls
  # GET /routine_controls.json
  def index
    @routine_controls = RoutineControl.all
  end

  # GET /routine_controls/1
  # GET /routine_controls/1.json
  def show
  end

  # GET /routine_controls/new
  def new
    @routine_control = RoutineControl.new
  end

  # GET /routine_controls/1/edit
  def edit
  end

  # POST /routine_controls
  # POST /routine_controls.json
  def create
    @routine_control = RoutineControl.new(routine_control_params)

    respond_to do |format|
      if @routine_control.save
        format.html { redirect_to @routine_control, notice: 'Routine control was successfully created.' }
        format.json { render :show, status: :created, location: @routine_control }
      else
        format.html { render :new }
        format.json { render json: @routine_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routine_controls/1
  # PATCH/PUT /routine_controls/1.json
  def update
    respond_to do |format|
      if @routine_control.update(routine_control_params)
        format.html { redirect_to @routine_control, notice: 'Routine control was successfully updated.' }
        format.json { render :show, status: :ok, location: @routine_control }
      else
        format.html { render :edit }
        format.json { render json: @routine_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routine_controls/1
  # DELETE /routine_controls/1.json
  def destroy
    @routine_control.destroy
    respond_to do |format|
      format.html { redirect_to routine_controls_url, notice: 'Routine control was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_routine_control
      @routine_control = RoutineControl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def routine_control_params
      params.require(:routine_control).permit(:enabled, :monthly)
    end
end
