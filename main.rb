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
	# has_many :comments if so add fk subreddit_name column migration
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
	redirect "/r/:name"
end 

get '/newest' do
	@submissions = Submission.all.order('timestamp DESC')
	erb :show_newest_submissions
end

get '/r/:subreddit_name' do # consider adding @subreddit = Subreddit.find(:subreddit_name)
							# or else @subreddit = :subreddit_name for use in page layout
							# Also--if .find doesn't work, try .find_by subreddit_name: 
							# "#{:subreddit_name}"
	@submissions = Submission.all.find(:subreddit_name).order('up_votes DESC')
	erb :show_subreddits_most_popular_submissions
end

get '/r/:subreddit_name/new' do 
	@subreddit = :subreddit_name
	erb :show_form_for_new_submission_to_subreddit
end

post '/r/:subreddit_name/create' do 
	@submission = Submission.create(subreddit_name: params[:subreddit_name], url: params[:url], image_url: params[:image_url], body: params[:body], author: params[:author])
	redirect "/newest"
end 

get '/r/:subreddit_name/newest' do #consider using submission_id instead of timestamp
	@submissions = Submission.all.find(:subreddit_name).order('timestamp DESC')
	erb :show_subreddits_newest_submissions
end

get '/r/:subreddit_name/:submission_name' do
	# add new comments form from here
	@subreddit = :subreddit_name
	@submission = @submission_name
	@comments = Comments.all.find_by(subreddit_name: "#{:subreddit_name}", submission_name: "#{:submission_name}")
	# @comments = Comments.all.find_by subreddit_name: @subreddit, submission_name: @submission
	erb :show_subreddits_submissions_comments_page #unfinished
end

post '/r/:subreddit_name/:submission_name/create' do # consider moving this above post for
												# making new submissions to subreddits
	@comment = Comment.create(author: params[:author], body: params[:body])											
end

# remember to rollback and re-migrate


