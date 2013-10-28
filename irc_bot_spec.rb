require 'rspec'
require './irc_bot'

describe HedonismBot do
  before do
    @heddy = HedonismBot.new
  end

  it 'loves chocolate' do
    @heddy.loves.should == "chocolate"
  end
end