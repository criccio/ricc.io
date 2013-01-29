class AddHitCountToLinks < ActiveRecord::Migration
  def change
    add_column :links, :hit_count, :integer, :default => 0
  end
end
