class CreateTopics < ActiveRecord::Migration
  def up
    create_table :topics do |t|
      t.string :name

      t.timestamps null: false
    end

    topics = ["Culture and the arts",
     "Geography and places",
     "Health and fitness",
     "History and events",
     "Mathematics and logic",
     "Natural and physical sciences",
     "People and self",
     "Philosophy and thinking",
     "Religion and belief systems",
     "Society and social sciences",
     "Technology and applied sciences" ]
    topics.each do |topic|
      Topic.create!(name: topic)
    end
  end

  def down
    drop_table :topics
  end
end
