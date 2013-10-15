class AddFkColumnToSubmissions < ActiveRecord::Migration
  def up
  	add_column :submissions, :subreddit_name, :string
  end

  def down
  	remove_column :submissions, :subreddit_name
  end
end
