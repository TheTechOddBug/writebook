class RemoveParentFromLeafs < ActiveRecord::Migration[7.2]
  def change
    remove_column :leafs, :parent_id, :integer
  end
end
