require 'socket'
require 'json'
class Task < ActiveRecord::Base
	def send_data
		host='localhost'
		port='6002'
		server = TCPSocket.open(host,port)
		server.send(self.jsonfy,0)
		status_returned = server.recv(100)
		JSON.load(status_returned)
	end
	
	def jsonfy
		{'code':self.code,'description':self.description}.to_json
	end
	
end
