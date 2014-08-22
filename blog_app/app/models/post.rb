class Post < ActiveRecord::Base
  has_many :comments
  has_many :blogs
  has_many :tags, :through => :blogs
end
