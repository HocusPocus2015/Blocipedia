class Topic < ActiveRecord::Base
  belongs_to :wiki

  def self.foo
    ["Culture and the arts",
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
  end
end
