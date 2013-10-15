class CreateSubmissions < ActiveRecord::Migration
  def up
  	create_table :submissions do |t|
      t.string :name
  		t.string :url
      t.string :image_url
  		t.text :body
  		t.string :author
  		t.integer :up_votes
  		t.integer :down_votes
  		t.timestamps
  	end
  end

  def down
  	drop_table :submissions
  end
end
