class User < ActiveRecord::Base
  has_many :comments
  has_many :articles
  validates :name , presence: true, length: {minimum: 4},
            uniqueness: { case_sensitive: false}
end
