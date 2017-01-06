# Author: Fernando Oliveira
# Data  : 2017-01-06

require "slack"

$token = 
$client = Slack::Client.new token: $token

$param1 = ARGV[0]
$param2 = ARGV[1]
$param3 = ARGV[2]

# Get users list
def getUsers(user)
	users = Hash[$client.users_list["members"].map{|m| [m["id"], m["name"]]}]
	return users.key(user)
end

def getChannels(channel)
	channels = Hash[$client.channels_list["channels"].map{|m| [m["id"],m["name"]]}]
	return channels.key(channel)
end

def create_channel(name=$param2)
	$client.channels_create name: name
end

def channels_invite()
	channel = getChannels($param2)
	user = getUsers($param3)
	$client.channels_invite channel: channel, user: user
end

def channels_kick()
	channel = getChannels($param2)
	user = getUsers($param3)
	$client.channels_kick channel: channel, user: user
end

case $param1
	when "create_channel"
		create_channel 
	when "channels_invite"
		channels_invite
	when "channels_kick"
		channels_kick
	when "getChannels"
		getChannels
	when "getUsers"
		getUsers
	else
		puts "********************************************************"
		puts " SlackProvisiong by BRFSO                            "
		puts " usage: 						     "
		puts "  ruby ./slackProvision.rb <Operator> <Param1> <Param2>"
		puts "  Operators:                                           " 
		puts "   create_channel <channel name>                        "
		puts "   channels_invite <channel name> <username>            "
		puts "   channels_kick                                        "
		puts "********************************************************"
		
end
