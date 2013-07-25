class CreateLike < ActiveRecord::Migration
  def self.up
  	create_table :likes do |t|
  		t.references :application_user
  		t.references :post
  	end
  end

  def self.down
  	drop_table :likes
  end
end
