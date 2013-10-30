require './argument_bots_v2'

channel = "#bitmaker"
channel = "##{ARGV[0]}" unless ARGV[0] == nil

@nbot = NiceBot.new("NiceBot")
@nbot.connect("chat.freenode.net","6667","#bitmaker")
@nbot.run