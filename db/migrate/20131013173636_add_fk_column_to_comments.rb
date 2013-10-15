class AddFkColumnToComments < ActiveRecord::Migration
  def up
  	add_column :comments, :submission_name, :string
  end

  def down
  	remove column, :comments, :submission_name
  end
end
