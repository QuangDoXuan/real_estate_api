class Product < ApplicationRecord
  belongs_to :category
  belongs_to :project, optional: true
  belongs_to :category, optional: true
  belongs_to :pref, optional: true
end
