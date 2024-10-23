class Product < ApplicationRecord
  acts_as_paranoid
  has_many_attached :images, dependent: :delete_all
end
