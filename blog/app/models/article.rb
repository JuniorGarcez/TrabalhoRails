class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5}

  def self.search(query)
    where("title ilike ? or text ilike ?", "%#{query}%", "%#{query}%")
    #where("text like ?", "%#{query}%")
  end

#  scope :search, ->(query) { where("title like ?", "%#{query}%") }
end
