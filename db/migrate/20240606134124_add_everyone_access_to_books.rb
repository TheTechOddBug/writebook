class AddEveryoneAccessToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :everyone_access, :boolean, default: true, null: false
  end
end
