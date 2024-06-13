class AddThemeToSection < ActiveRecord::Migration[7.2]
  def change
    add_column :sections, :theme, :string
  end
end
