class AddThemeToBook < ActiveRecord::Migration[8.0]
  change_table(:books) do |t|
    t.integer :theme, default: 0, null: false
  end
end
