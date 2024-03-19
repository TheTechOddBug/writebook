class AddPositionScoreToLeaves < ActiveRecord::Migration[7.2]
  def change
    change_column :leaves, :position, :double, null: false
    rename_column :leaves, :position, :position_score
  end
end
