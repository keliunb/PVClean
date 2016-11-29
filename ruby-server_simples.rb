#!/usr/bin/ruby
require 'socket'

#Abre o servidor TCP que será utilizado nos testes
server = TCPServer.new("localhost", 8000)
loop {
  #aceite a conexão com o cliente
  client = server.accept

  #Mensagem recebida do cliente, de até 100 caracteres
  mensagem_recebida = client.recv(100)

  #Apresenta no terminal qual foi a mensagem recebida
  if mensagem_recebida == "1_3"
    print mensagem_recebida + ": Limpeza completa\n"
    #Envia para o servidor a mensagem de sucesso
    client.send("Servidor recebeu " + mensagem_recebida + "\n", 0)
  elsif mensagem_recebida == "0_0"
    print mensagem_recebida + ": Parada completa\n"
    #Envia para o servidor a mensagem de sucesso
    client.send("Servidor recebeu " + mensagem_recebida + "\n", 0)
  elsif mensagem_recebida == "1_2"
    print mensagem_recebida + ": Limpeza da primeira metade das placas\n"
    #Envia para o servidor a mensagem de sucesso
    client.send("Servidor recebeu " + mensagem_recebida + "\n", 0)
  elsif mensagem_recebida == "2_3"
    print mensagem_recebida + ": Limpeza da segunda metade das placas\n"
    #Envia para o servidor a mensagem de sucesso
    client.send("Servidor recebeu " + mensagem_recebida + "\n", 0)
  end

  #Tempo para sincronizar o envio da mensagem para o cliente
  sleep 0.001
  #Envia para o servidor a mensagem de sucesso
  client.send("Servidor recebeu " + mensagem_recebida + "\n", 0)

    #client.send("Servidor recebeu " + mensagem_recebida + "\n", 0)
#Envia mensagem para o Cliente
  #client.send("Teste de envio de mensagem - PI2",0)

  #Fecha a conexão com o cliente
  client.close
}
