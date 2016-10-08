#!/usr/bin/ruby
require 'socket'
server = TCPServer.new("", 6002)
loop {
  client = server.accept
  mensagem_recebida = client.recv(100)
    client.send("recebi " + mensagem_recebida, 0)
    print mensagem_recebida

  client.send("olaaaaaaaa",0)
  #client.puts "PI2 :-)"
  client.close
}
