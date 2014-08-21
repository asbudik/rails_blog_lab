class Post < ActiveRecord::Base

  has_many :blogs
  has_many :tags, :through => :blogs
end
