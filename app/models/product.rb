class Product < ApplicationRecord
  has_many_attached :images, dependent: :delete_all
end
