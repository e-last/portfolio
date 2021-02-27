class Record < ApplicationRecord

  belongs_to :user
  belongs_to :category, optional: true
  has_many :post_comments, dependent: :destroy
  
  validates :start, presence: true
  validate :date_check
  
  def date_check
    if self.end.present?
      if self.start > self.end
        errors.add(:end, "正しい時刻を入力してください")
      end
    end
  end
  
end