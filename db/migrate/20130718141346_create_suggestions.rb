class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :author
      t.text :thoughts

      t.timestamps
    end
  end
end
