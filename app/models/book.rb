class Book < ApplicationRecord
  validates_presence_of :title, :author, :page, :text
  searchkick
end
