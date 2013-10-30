require './argument_bots_v2'

channel = "#bitmaker"
channel = "##{ARGV[0]}" unless ARGV[0] == nil

@mbot = MeanBot.new("MeanBot")
@mbot.connect("chat.freenode.net","6667","#bitmaker")
@mbot.run