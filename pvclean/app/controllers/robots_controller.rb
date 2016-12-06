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

  def complete
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    Thread.new do
      #hostname='192.168.43.180'
      hostname = '192.168.43.30'
      port = 8002

      #abre o servidor no host e port especificado
      socket = TCPSocket.new(hostname,port)

      #Mensagem que será enviada, indicando intervalo de placas a serem limpadas
      mensagem = "0_2"

      #Envia Mensagem para o servidor
      socket.send(mensagem, 0) #envia mensagem

      #Printa no terminal qual mensagem foi enviada
      print "Enviei: " + mensagem + "\n"
      sleep 0.5

      #verifica se a mensagem foi enviada corretamente (O servidor recebe a mensagem e envia uma de confirmação)
      confirmacao_envio = socket.recv(25)
      if confirmacao_envio
        print "Primeira resposta: " + confirmacao_envio + "\n"
        #print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      #Segunda Mensagem recebida
      resposta = socket.recv(25)
      if resposta
        print "Segunda resposta: " + resposta + "\n"
      end

      #Terceira mensagem recebida
      resposta2 = socket.recv(160)
      if resposta2
        print "Terceira resposta: " + resposta2 + "\n"
      end

    end
    sleep 0.05
    flash[:notice] = " ........\"Total clean\" started !"
    redirect_to :back
  end

  def stop
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    Thread.new do
      #hostname='192.168.43.180'
      hostname = '192.168.43.30'
      port = 8016

      #abre o servidor no host e port especificado
      socket = TCPSocket.new(hostname,port)
      mensagem = "0_0"
      socket.send(mensagem, 0) #envia mensagem
      print "Enviei: " + mensagem + "\n"

      #verifica se a mensagem foi enviada corretamente (O servidor recebe a mensagem e envia uma de confirmação)
      confirmacao_envio = socket.recv(100) #recebe mensagem
      if confirmacao_envio = mensagem
        print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      #Segunda Mensagem recebida
      resposta = socket.recv(100)
      if resposta
        print "recebi: " + resposta + "\n"
      end

    end
    flash[:notice] = " ........\"Stop robot path\" started !"
    redirect_to :back
  end

  def first_half
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    Thread.new do
      #hostname='192.168.43.180'
      hostname = '192.168.43.30'
      port = 8016

      #abre o servidor no host e port especificado
      socket = TCPSocket.new(hostname,port)
      mensagem = "1_2"
      socket.send(mensagem, 0) #envia mensagem
      print "Enviei: " + mensagem + "\n"

      #verifica se a mensagem foi enviada corretamente (O servidor recebe a mensagem e envia uma de confirmação)
      confirmacao_envio = socket.recv(100) #recebe mensagem
      if confirmacao_envio = mensagem
        print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      #Segunda Mensagem recebida
      resposta = socket.recv(100)
      if resposta
        print "recebi: " + resposta + "\n"
      end

    end
    flash[:notice] = " ........\"First half robots path\" started !"
    redirect_to :back
  end

  def last_half
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    Thread.new do
      #hostname='192.168.43.180'
      hostname = '192.168.43.30'
      port = 8016

      #abre o servidor no host e port especificado
      socket = TCPSocket.new(hostname,port)
      mensagem = "2_3"
      socket.send(mensagem, 0) #envia mensagem
      print "Enviei: " + mensagem + "\n"

      #verifica se a mensagem foi enviada corretamente (O servidor recebe a mensagem e envia uma de confirmação)
      confirmacao_envio = socket.recv(100) #recebe mensagem
      if confirmacao_envio = mensagem
        print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      #Segunda Mensagem recebida
      resposta = socket.recv(100)
      if resposta
        print "Recebi: " + resposta + "\n"
      end

    end
    flash[:notice] = " ........\"Last half robots path\" started !"
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
