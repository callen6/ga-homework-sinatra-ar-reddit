class AddFkColumnToComments < ActiveRecord::Migration
  def up
  	add_column :comments, :submission_id, :integer
  end

  def down
  	remove column, :comments, :submission_id
  end
end
