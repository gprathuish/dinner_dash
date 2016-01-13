class CategoriesItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :category
  #validates_uniqueness_of :category_id, :scope => :item_id
  #validates_uniqueness_of [:category_id, :item_id]
end

