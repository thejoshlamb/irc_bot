require 'socket'
require 'helpers'

class ArgumentBot
  attr_reader :nick
	
	def initialize(nick)
		@nick = nick
    @termcolor = "\e[33m"
    log("Initializing ArgumentBot...")
	end

	def connect(server,port,channel) # connects to given channel and sets user
		@server = server
		@port = port
		@channel = channel
		@channel_prefix = "privmsg #{@channel} :"
		@irc_server = TCPSocket.open(server, port)
    @killswitch = "go away ab"
		say_global("USER BMLbot 0 * BMLbot")
		say_global("NICK [BML]#{@nick}")
		say_global("JOIN #{@channel}")
		log("connected to #{server} #{port} #{channel}")
	end

  def log(text) # nice colorful command line log
    puts "#{@nick}: #{@termcolor}#{text}#{@reset}"
  end

	def say_global(msg) # global say for commands
		log(msg)
		@irc_server.puts msg
	end

  def say(msg) # say to channel
    say_global("PRIVMSG #{@channel} : #{msg}")
  end

  def run
    until @irc_server.eof?
      msg = @irc_server.gets.downcase
      puts msg
      quit if msg.include?(@killswitch)
      parse(msg)
    end
  end

	def quit # quits gracefully
    say_global "PART ##{@channel} :To sleep, perchance to dream."
    say_global 'QUIT'
    exit
  end
end

class MeanBot < ArgumentBot
  
  def initialize(nick) # sets up some mean things to say and sets log color to red
    @nick = nick
    @mean_things = ["bots are stupid!","too many bots in here","ugh,another bot???","TOO MANY BOTS!","i wish there weren't so many bots in here...","no more bots!","go home bots!","shut up, bot!"]
    @insult_nicebot = ["nicebot is a wussbot","shut up nicebot","SHUT UP NICEBOT","SHUT UP","whatever, loserbot","somebody call the waaaahhmbulance","whatever, crybaby"]
    @killswitch = "go away mb"
    @termcolor = "\x1B[0;31m"
    @reset = "\x1B[0m"
    log("Initializing MeanBot...")
  end

  def parse(msg) #parses the irc stream
    puts "<< #{msg.to_s.strip}"
    words = msg.split(" ")
    sender = words[0]
    user = sender.split("!")[0].clean
    raw = words[1]
    channel = words[2]
    log("sender:#{sender}")
    log("user:#{user}")
    log("raw:#{raw}")
    log("channel:#{channel}")
    # Handles pings first
    if /^ping (.*?)\s$/.match(msg) 
      say_global("pong #{$1}")
    elsif raw.downcase == "privmsg" # in-channel chatter
      msg = words[3..-1].clean
      log("message from #{user}: #{msg}")
      # Parse commands
      if user.include?("bot") && (1 + Random.rand(6)) == 6
        say(@mean_things.sample) unless user.include?("nicebot")
      elsif user.include?("nicebot") && (1 + Random.rand(2)) == 2
        say(@insult_nicebot.sample)
        sleep(30)
      end
    end
  end
end

class NiceBot < ArgumentBot

  def initialize(nick)
    @nick = nick
    @nice_things = ["leave them alone, meanbot!","shut up, meanbot!","bots are awesome, don't listen to meanbot!","bots are the coolest! go away, meanBot!", "MEANBOT SUCKS","meanbot, more like... buttbot.","bots are people too","relax, meanbot"]
    @swearing = ["fuck","shit","ass","bitch","fag"]
    @calm_down = ["let's keep it civil","calm down","relax","watch your language","chill out pls"]
    @killswitch = "go away nb"
    @reset = "\x1B[0m"
    @termcolor = "\e[34m"
    log("Initializing NiceBot...")
  end

  def run
    until @irc_server.eof?
      msg = @irc_server.gets.downcase
      puts msg
      quit if msg.include?(killswitch)
      parse(msg)
    end
  end

  def parse(msg)
    puts "<< #{msg.to_s.strip}"
    words = msg.split(" ")
    sender = words[0]
    user = sender.split("!")[0].clean
    raw = words[1]
    channel = words[2]
    log("sender:#{sender}")
    log("user:#{user}")
    log("raw:#{raw}")
    log("channel:#{channel}")
    # Handling pings
    if /^ping (.*?)\s$/.match(msg) 
      say_global("pong #{$1}")
    elsif raw.downcase == "privmsg"
      msg = words[3..-1].clean
      log("message from #{user}: #{msg}")
      # Parse commands
      if user.include?("meanbot") && (1 + Random.rand(2)) == 2
        say(@nice_things.sample)
      elsif @swearing.any?{|word| msg.include?(word)}
        say(@calm_down.sample)
      end
    end
  end
end

