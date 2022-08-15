class User < ActiveRecord::Base
  has_many :comments
  has_many :articles
  validates :mail, :name, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 254 }
  #validates :name, presence: true, length: {minimum: 4}, uniqueness: {case_sensitive: false}
  before_save :downcase_fields

  def downcase_fields
    self.name.downcase!
  end

end
