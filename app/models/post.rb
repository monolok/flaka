class Post < ApplicationRecord
	validates :title, presence: true, length: {maximum: 140}
	validates :body, presence: true

	has_many :category_posts
	has_many :categories, :through => :category_posts 

	def self.search(search)
		where('title ILIKE :search OR body ILIKE :search', search: "%#{search}%").order('id DESC')
	end

end