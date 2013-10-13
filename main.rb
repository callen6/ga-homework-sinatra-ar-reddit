require 'pg'
require 'pry'
require 'rake'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, { adapter: "postgresql",
				database: "ga-reddit",
				host: "localhost"}
class Subreddit < ActiveRecord::Base
	has_many :submissions
end
class Submission < ActiveRecord::Base
	has_many :comments
	belongs_to :subreddit
end

class Comment < ActiveRecord::Base
	belongs_to :submission
end

get '/' do 
	erb :show_most_popular_submisssions
end

get '/new' do
	erb :show_form_for_new_subreddit
end

get '/newest' do

	erb :show_newest_submissions
end

get '/r/:sub-reddit-name' do

	erb :show_subreddits_most_popular_submissions
end

get '/r/:sub-reddit-name/new' do 

	erb :show_form_for_new_submission_to_subreddit
end

get '/r/:sub-reddit-name/newest' do

	erb :show_subreddits_newest_submissions
end

get '/r/:sub-reddit-name/:submission-name' do
	# add new comments form from here
	erb :show_subreddits_submissions_comments_page
end


