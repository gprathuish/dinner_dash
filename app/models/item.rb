class Item < ActiveRecord::Base
	has_many :carts
	has_many :orders, :through => :carts

	has_many :categories_items, dependent: :destroy
	has_many :categories, through: :categories_items

	has_many :pictures, as: :imageable
	accepts_nested_attributes_for :pictures, allow_destroy: true
	accepts_nested_attributes_for :categories_items, reject_if: lambda { |args| args['category_id'].blank?  }, allow_destroy: true
	validates :title, :description, :price, presence: true
end
