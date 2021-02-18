class Record < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :post_comments, dependent: :destroy


end