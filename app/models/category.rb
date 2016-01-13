class Category < ActiveRecord::Base
	belongs_to :item

	has_many :categories_items, dependent: :destroy
	has_many :items, through: :categories_items, dependent: :destroy
end
