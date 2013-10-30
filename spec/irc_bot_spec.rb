require 'rspec'
require 'irc_bot'

describe HedonismBot do
  
  let(:bot) { HedonismBot.new("specbot")}

  before do
    @msg_system = ":fakefake.freenode.net 005 hedonismbotbml chantypes=# excepts invex chanmodes=eibq,k,flj,cflmpqscgimnprstz chanlimit=#:120 prefix=(ov)@+ maxlist=bqei:100 modes=4 network=freenode knock statusmsg=@+ callerid=g :are supported by this server"
    @msg_user = ":joshlamb!~joshlamb@76-10-128-136.dsl.fakefake.com privmsg #bitmakerlabs :hi there" 
    @msg_bot = ":joshbot!~joshlamb@76-10-128-136.dsl.fakefake.com privmsg #bitmakerlabs :hi there"
    @msg_names = "fakefake.freenode.net 376 hedonismbotbml : Names: makeready joshbot jacob_zrobin"
  end

  it 'initializes with a name' do
  	expect(bot.nick).to eq("specbot")
  end

  it 'knows commands' do
    bot.commands.should == {"bots?" => :list_bots}
  end

  it 'connects to a server' do
    bot.connect("chat.freenode.net","6667","#reptiles").should eq(puts "connected to chat.freenode.net 6667 reptiles")
  end
end