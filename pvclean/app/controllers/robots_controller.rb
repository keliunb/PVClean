class RobotsController < ApplicationController
  before_action :set_robot, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # If used, will break the routine method. so DO NOT USE it unless you don't need it.
  #load_and_authorize resource


  # GET /robots
  # GET /robots.json
  def index
    @robots = Robot.all
  end

  def routine
    #test were made with the code on https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    Thread.new do
      hostname = 'localhost'
      port = 6002

      #abre o servidor no host e port especificado
      s = TCPSocket.new(hostname,port)
      teste = "teste"
      s.send(teste, 0) #envia mensagem
      #confirmacao_a = s.recv(100) #recebe mensagem
      if confirmacao_a = teste
        print "Confirmacao, enviou: " + teste + "\n"
      end

       confirmação = s.recv(100)
        if confirmação
          print "recebi: " + confirmação + "\n"
        end

    end
    redirect_to :back
  end

  # GET /robots/1
  # GET /robots/1.json
  def show
    robot_infos = @robot.robot_infos

    @robot_info = robot_infos.last unless robot_infos.empty?

    routines = @robot.routines

    @routine = routines unless routines.empty?
  end

  # GET /robots/new
  def new
    @robot = Robot.new
  end

  # GET /robots/1/edit
  def edit
  end

  # POST /robots
  # POST /robots.json
  def create
    @robot = Robot.new(robot_params)

    respond_to do |format|
      if @robot.save
        format.html { redirect_to @robot, notice: 'Robot was successfully created.' }
        format.json { render :show, status: :created, location: @robot }
      else
        format.html { render :new }
        format.json { render json: @robot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /robots/1
  # PATCH/PUT /robots/1.json
  def update
    respond_to do |format|
      if @robot.update(robot_params)
        format.html { redirect_to @robot, notice: 'Robot was successfully updated.' }
        format.json { render :show, status: :ok, location: @robot }
      else
        format.html { render :edit }
        format.json { render json: @robot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /robots/1
  # DELETE /robots/1.json
  def destroy
    @robot.destroy
    respond_to do |format|
      format.html { redirect_to robots_url, notice: 'Robot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_robot
      @robot = Robot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def robot_params
      params.require(:robot).permit(:status, :identifier)
    end
end
