class CreateWiki < ActiveRecord::Migration
  def change
    create_table :wiki do |t|
      t.string :title
      t.text :body
      t.dropdown :dropdown_topics_menu
      t.boolean :private
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
