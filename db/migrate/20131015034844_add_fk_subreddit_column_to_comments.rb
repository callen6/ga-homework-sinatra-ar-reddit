class AddFkSubredditColumnToComments < ActiveRecord::Migration
  def up
  	add_column :comments, :subreddit_name, :string
  end

  def down
  	remove_column :comments, :subreddit_name
  end
end
