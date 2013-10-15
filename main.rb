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
	@submissions = Submission.all.order('up_votes DESC')
	erb :show_most_popular_submisssions
end

get '/new' do
	erb :show_form_for_new_subreddit
end

post '/create' do
	@subreddit = Subreddit.create(name: params[:name])
	redirect "/r/#{:name}"
end 

get '/newest' do
	@submissions = Submission.all.order('timestamp DESC')
	erb :show_newest_submissions
end

get '/r/:subreddit_name' do 
	@submissions = Submission.all.find('subreddit_name').order('up_votes DESC')
	erb :show_subreddits_most_popular_submissions
end

get '/r/:subreddit_name/new' do 
	erb :show_form_for_new_submission_to_subreddit
end

post '/r/:subreddit_name/create' do #unfinished
	@submission = Submission.create(url: params[:url], image_url: params[:image_url], body: params[:body], author: params[:author])
	redirect "/newest"
end 


get '/r/:subreddit_name/newest' do
	@submissions
	erb :show_subreddits_newest_submissions
end

get '/r/:subreddit_name/:submission_name' do
	# add new comments form from here
	erb :show_subreddits_submissions_comments_page
end


