class User < ActiveRecord::Base
  has_many :comment
  validates :name , presence: true, length: {minimum: 5}
end
