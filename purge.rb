
require 'rubygems'
require 'twitter'

Twitter.configure do |config|
	config.consumer_key = CONSUMER_KEY
	config.consumer_secret = CONSUMER_SECRET
	config.oauth_token = OAUTH_TOKEN
	config.oauth_token_secret = OAUTH_TOKEN_SECRET
end

username = YOUR_USERNAME

cursor = -1
account_friends = []
while cursor != 0 do
	friends = Twitter.friend_ids(username, { :cursor => cursor })
	cursor = friends.next_cursor
	friends.ids.each do |friend|
		account_friends << friend
	end
end


cursor = -1
account_followers = []
while cursor != 0 do
	followers = Twitter.follower_ids(username, { :cursor => cursor })
	cursor = followers.next_cursor
	followers.ids.each do |follower|
		account_followers << follower
	end
end

account_followers.each do |follower|
	if account_friends.include?(follower)
		puts "Not removing #{follower} - you follow them."
	else
		Twitter.block(follower)
		puts "Removing #{follower} - you don't follow them."
		sleep(2)
	end
end
