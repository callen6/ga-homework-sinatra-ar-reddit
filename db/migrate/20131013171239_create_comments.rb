class CreateComments < ActiveRecord::Migration
  def up
  	create_table :comments do |t|
  		t.string :author
  		t.text :body
  		t.integer :up_votes
  		t.integer :down_votes
  		t.timestamps
    end
  end

  def down
  	drop_table :comments
  end
end
