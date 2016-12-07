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

    #São declaradas variáveis globais, que são utilizadas dentro da thread.
    $tensao = ""
    $temperatura = ""
    $reservatorio = ""
    $chuva = ""
    $confirmacao_inicio
    $posicao = ""

    #puts "Tensao: " + $tensao + ". Temperatura: " + $temperatura + "\n"
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    inicio_limpeza = Thread.new($tensao, $temperatura, $reservatorio, $chuva, $confirmacao_inicio, $posicao) do

      #hostname='localhost'
      hostname = '192.168.43.30'
      port = 8011

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
      #formato da mensagem: 12.123.456_19.91_1_1_0
      #formato da mensagem: 13.117.58_17.58_1_1_1
      #formato: VV.vv#.##_TT.tt_C_R_S
      primeira_resposta = socket.recv(21)
      if primeira_resposta
        print "Primeira resposta: " + primeira_resposta + "\n"
        #print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      #$tensao = primeira_resposta[0..4]
      #$temperatura = primeira_resposta[11..15]
      #$reservatorio = primeira_resposta[17..17]
      #$chuva = primeira_resposta[19..19]
      #$confirmacao_inicio = primeira_resposta[21..21]

      $tensao = primeira_resposta[0..4]
      $temperatura = primeira_resposta[10..14]
      $chuva = primeira_resposta[16..16]
      $reservatorio = primeira_resposta[18..18]
      $confirmacao_inicio = primeira_resposta[20..20]

      #$posicao = ""

      #apresenta dados lidos
      print "Tensao: " + $tensao + "\n"
      print "Temperatura: " + $temperatura + "\n"
      print "Reservatorio: " + $reservatorio + "\n"
      print "Chuva: " + $chuva + "\n"
      print "Confirmacao: " + $confirmacao_inicio + "\n"

      sleep 0.5
      #Segunda Mensagem recebida - Caso necessário
      resposta = socket.recv(21)
      if resposta
        print "Segunda resposta: " + resposta + "\n"
      end

#      socket.close
    end

    #É necessário "dormir" para que a thread rode antes e atualize os dados, que em seguida serão utilizados
    sleep 2.50

    #Transforma cada um dos dados lidos nos sensores em float
    tensao_final = $tensao.to_f
    temperatura_final = $temperatura.to_f
    reservatorio_final = $reservatorio.to_f
    chuva_final = $chuva.to_f
    #String no final
    confirmacao_comecou = $confirmacao_inicio
    confirmacao_comecou2 = $confirmacao_inicio.to_f

    #Caso queira verificar no console
    #puts "Dados apos a limpeza"
    #puts " - - - - - - - - - - - - - - "
    #puts temperatura_final.to_s + " - " + $temperatura
    #puts "Tensao final: " + tensao_final.to_s
    #puts "Reservatorio final: " + reservatorio_final.to_s
    #puts "Chuva final: " + chuva_final.to_s
    #puts "Confirmacao_comecou: " + confirmacao_comecou.to_s

    #o primeiro parâmetro é o id do robô, o segundo os dados a serem atualizados
    Robot.first.robot_infos.update( [2],
        [
          {battery: tensao_final, temperature: temperatura_final, water: reservatorio_final,
            humidity: chuva_final, position: confirmacao_comecou},
        ])
    sleep 0.3

    #SE = 0, tá chovendo
    if chuva_final == 0
      flash[:info] = "It was not possible to start the cleaning routine due to rain."
    #RESERVATORIO = 0, sem água
    elsif tensao_final <= 10.0 or temperatura_final >= 50.0 or reservatorio_final == 0
      flash[:danger] = "Low battery or temperature too high or reservatory too low."
    elsif confirmacao_comecou2 == 0
      flash[:warning] = "It was not possible to start the cleaning routine. Please check the sensors."
    #CONFIRMACAO = 1, tudo certo
    elsif confirmacao_comecou2 == 1 and tensao_final > 10 and temperatura_final < 50 and reservatorio_final == 1 and chuva_final == 1
      flash[:success] = "Success: Clean started."
    end

    #Aqui serão disponibilizadas as mensagens para o usuário (se chuva=1 notícia que n começou pq tá chovendo e etc)
    #flash[:notice] = " ........\"Total clean\" started !"
    redirect_to :back
  end

  def first_half
    #São declaradas variáveis globais, que são utilizadas dentro da thread.
    $tensao = ""
    $temperatura = ""
    $reservatorio = ""
    $chuva = ""
    $confirmacao_inicio
    $posicao = ""

    #puts "Tensao: " + $tensao + ". Temperatura: " + $temperatura + "\n"
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    inicio_limpeza = Thread.new($tensao, $temperatura, $reservatorio, $chuva, $confirmacao_inicio, $posicao) do

      #hostname='localhost'
      hostname = '192.168.43.30'
      port = 8011

      #abre o servidor no host e port especificado
      socket = TCPSocket.new(hostname,port)

      #Mensagem que será enviada, indicando intervalo de placas a serem limpadas
      mensagem = "0_1"

      #Envia Mensagem para o servidor
      socket.send(mensagem, 0) #envia mensagem

      #Printa no terminal qual mensagem foi enviada
      print "Enviei: " + mensagem + "\n"
      sleep 0.5

      #verifica se a mensagem foi enviada corretamente (O servidor recebe a mensagem e envia uma de confirmação)
      primeira_resposta = socket.recv(22)
      if primeira_resposta
        print "Primeira resposta: " + primeira_resposta + "\n"
        #print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      $tensao = primeira_resposta[0..4]
      $temperatura = primeira_resposta[10..14]
      $chuva = primeira_resposta[16..16]
      $reservatorio = primeira_resposta[18..18]
      $confirmacao_inicio = primeira_resposta[20..20]
      #$posicao = ""

      #apresenta dados lidos
      print "Tensao: " + $tensao + "\n"
      print "Temperatura: " + $temperatura + "\n"
      print "Reservatorio: " + $reservatorio + "\n"
      print "Chuva: " + $chuva + "\n"
      print "Confirmacao: " + $confirmacao_inicio + "\n"

      sleep 0.5
      #Segunda Mensagem recebida - Caso necessário
      resposta = socket.recv(22)
      if resposta
        print "Segunda resposta: " + resposta + "\n"
      end

#      socket.close
    end

    #É necessário "dormir" para que a thread rode antes e atualize os dados, que em seguida serão utilizados
    sleep 2.50

    #Transforma cada um dos dados lidos nos sensores em float
    tensao_final = $tensao.to_f
    temperatura_final = $temperatura.to_f
    reservatorio_final = $reservatorio.to_f
    chuva_final = $chuva.to_f
    #String no final
    confirmacao_comecou = $confirmacao_inicio
    confirmacao_comecou2 = $confirmacao_inicio.to_f

    #Caso queira verificar no console
    #puts "Dados apos a limpeza"
    #puts " - - - - - - - - - - - - - - "
    #puts temperatura_final.to_s + " - " + $temperatura
    #puts "Tensao final: " + tensao_final.to_s
    #puts "Reservatorio final: " + reservatorio_final.to_s
    #puts "Chuva final: " + chuva_final.to_s
    #puts "Confirmacao_comecou: " + confirmacao_comecou.to_s

    #o primeiro parâmetro é o id do robô, o segundo os dados a serem atualizados
    Robot.first.robot_infos.update( [2],
        [
          {battery: tensao_final, temperature: temperatura_final, water: reservatorio_final,
            humidity: chuva_final, position: confirmacao_comecou},
        ])
    sleep 0.3

    #SE = 0, tá chovendo
    if chuva_final == 0
      flash[:info] = "It was not possible to start the cleaning routine due to rain."
    #RESERVATORIO = 0, sem água
    elsif tensao_final <= 10.0 or temperatura_final >= 50.0 or reservatorio_final == 0
      flash[:danger] = "Low battery or temperature too high or reservatory too low."
    elsif confirmacao_comecou2 == 0
      flash[:warning] = "It was not possible to start the cleaning routine. Please check the sensors."
    #CONFIRMACAO = 1, tudo certo
    elsif confirmacao_comecou2 == 1 and tensao_final > 10 and temperatura_final < 50 and reservatorio_final == 1 and chuva_final == 1
      flash[:success] = "Success: Clean started."
    end

    redirect_to :back
  end

  def last_half
    #São declaradas variáveis globais, que são utilizadas dentro da thread.
    $tensao = ""
    $temperatura = ""
    $reservatorio = ""
    $chuva = ""
    $confirmacao_inicio
    $posicao = ""

    #puts "Tensao: " + $tensao + ". Temperatura: " + $temperatura + "\n"
    #tests were made with this code: https://github.com/keliunb/PVClean/blob/script_servidor/ruby-server_simples.rb
    inicio_limpeza = Thread.new($tensao, $temperatura, $reservatorio, $chuva, $confirmacao_inicio, $posicao) do

      #hostname='localhost'
      hostname = '192.168.43.30'
      port = 8011

      #abre o servidor no host e port especificado
      socket = TCPSocket.new(hostname,port)

      #Mensagem que será enviada, indicando intervalo de placas a serem limpadas
      mensagem = "1_2"

      #Envia Mensagem para o servidor
      socket.send(mensagem, 0) #envia mensagem

      #Printa no terminal qual mensagem foi enviada
      print "Enviei: " + mensagem + "\n"
      sleep 0.5

      #verifica se a mensagem foi enviada corretamente (O servidor recebe a mensagem e envia uma de confirmação)
      primeira_resposta = socket.recv(22)
      if primeira_resposta
        print "Primeira resposta: " + primeira_resposta + "\n"
        #print "Confirmacao, servidor recebeu:" + confirmacao_envio + "\n"
      end

      $tensao = primeira_resposta[0..4]
      $temperatura = primeira_resposta[10..14]
      $chuva = primeira_resposta[16..16]
      $reservatorio = primeira_resposta[18..18]
      $confirmacao_inicio = primeira_resposta[20..20]
      #$posicao = ""

      #apresenta dados lidos
      print "Tensao: " + $tensao + "\n"
      print "Temperatura: " + $temperatura + "\n"
      print "Reservatorio: " + $reservatorio + "\n"
      print "Chuva: " + $chuva + "\n"
      print "Confirmacao: " + $confirmacao_inicio + "\n"

      sleep 0.5
      #Segunda Mensagem recebida - Caso necessário
      resposta = socket.recv(22)
      if resposta
        print "Segunda resposta: " + resposta + "\n"
      end

#      socket.close
    end

    #É necessário "dormir" para que a thread rode antes e atualize os dados, que em seguida serão utilizados
    sleep 2.50

    #Transforma cada um dos dados lidos nos sensores em float
    tensao_final = $tensao.to_f
    temperatura_final = $temperatura.to_f
    reservatorio_final = $reservatorio.to_f
    chuva_final = $chuva.to_f
    #String no final
    confirmacao_comecou = $confirmacao_inicio
    confirmacao_comecou2 = $confirmacao_inicio.to_f

    #Caso queira verificar no console
    #puts "Dados apos a limpeza"
    #puts " - - - - - - - - - - - - - - "
    #puts temperatura_final.to_s + " - " + $temperatura
    #puts "Tensao final: " + tensao_final.to_s
    #puts "Reservatorio final: " + reservatorio_final.to_s
    #puts "Chuva final: " + chuva_final.to_s
    #puts "Confirmacao_comecou: " + confirmacao_comecou.to_s

    #o primeiro parâmetro é o id do robô, o segundo os dados a serem atualizados
    Robot.first.robot_infos.update( [2],
        [
          {battery: tensao_final, temperature: temperatura_final, water: reservatorio_final,
            humidity: chuva_final, position: confirmacao_comecou},
        ])
    sleep 0.3

    #SE = 0, tá chovendo
    if chuva_final == 0
      flash[:info] = "It was not possible to start the cleaning routine due to rain."
    #RESERVATORIO = 0, sem água
    elsif tensao_final <= 10.0 or temperatura_final >= 50.0 or reservatorio_final == 0
      flash[:danger] = "Low battery or temperature too high or reservatory too low."
    elsif confirmacao_comecou2 == 0
      flash[:warning] = "It was not possible to start the cleaning routine. Please check the sensors."
    #CONFIRMACAO = 1, tudo certo
    elsif confirmacao_comecou2 == 1 and tensao_final > 10 and temperatura_final < 50 and reservatorio_final == 1 and chuva_final == 1
      flash[:success] = "Success: Clean started."
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
