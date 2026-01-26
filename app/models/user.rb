class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Validations
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/

  validates :password,
    format: {
      with: VALID_PASSWORD_REGEX,
    },
    allow_nil: true
  
  
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  validates :last_name_kana, :first_name_kana,
    format: {
      with: VALID_KANA_REGEX,
    }

  validates :date_of_birth, presence: true
  
  # Associations
  has_many :goods, dependent: :destroy
  has_many :purchases, dependent: :destroy

end
