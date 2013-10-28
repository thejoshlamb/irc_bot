require "socket"

class HedonismBot
	
	def initialize(nick,server,port,channel)
		@nick = nick
		@server = server
		@port = port
		@channel = channel
		@interests = ["hedonismbot"]
		@channel_prefix = "privmsg #{@channel} :"
		@irc_server = TCPSocket.open(server, port)
		say_global("USER bhedonismbot 0 * BHedonismBot")
		say_global("NICK #{@nick}BML")
		say_global("JOIN #{@channel}")
		say_global("PRIVMSG #{@channel} :Let us party like the greeks of old. YOU KNOW THE ONES I MEAN.")
		#print("addr: ", s.addr.join(":"), "\n")
		#print("peer: ", s.peeraddr.join(":"), "\n")
	end

	def say_global(msg)
		puts msg
		@irc_server.puts msg
	end


  def say(msg)
    say("PRIVMSG #{@channel} :#{msg}")
  end

	def chat
		until @irc_server.eof? do
		  @msg = @irc_server.gets.downcase
		  puts @msg

		  @interested = false
		  @interests.each do |i|
			@interested = true if @msg.include? i
		  end

		  if @msg.include?(@channel_prefix) and @interested
		  	response = "mmmmmmmmmyes?"
		  	say(response)
		  end
		end
end
end

bot = HedonismBot.new("HedonismBot","chat.freenode.net","6667","#bitmaker")
bot.chat
