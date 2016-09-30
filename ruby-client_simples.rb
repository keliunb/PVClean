#!/usr/bin/ruby
require 'socket'


#hostname = '192.168.43.180'
#port = 8000

#host e port do servidor
hostname = 'localhost'
port = 6002

#abre o servidor no host e port especificado
s = TCPSocket.open(hostname,port)

#while line = s.gets
#  puts line.chomp
#end
#sair = false
#loop do
  puts "Digite o valor a enviar"
  teste = gets.chomp
  s.send(teste, 0) #envia mensagem
  confirmacao_a = s.recv(100) #recebe mensagem
  if confirmacao_a = "recebi " + teste
    print "Confirmacao, enviou: " + teste + "\n"
  end

  #s.write(teste)
  aeho = s.recv(100)
  if aeho
    print "recebi: " + aeho + "\n"
  end

#  puts "Deseja sair? s/n"
#  msg_sair = gets.chomp
#  if msg_sair == "s"
 #   sair = true
  #elsif msg_sair == "n"
  #  sair = false
  #else
  #  puts "Valor incorreto"
  #end
  #break if sair == true
#end
  s.close

#Servidor em C
#s = TCPSocket.new(hostname,6001)
#s.send(teste, 0)
#s.close
