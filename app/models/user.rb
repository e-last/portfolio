class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  has_many :records, dependent: :destroy
  has_many :categories, dependent: :destroy



  def active_for_authentication?
    super && (self.is_valid == true)
  end

end
