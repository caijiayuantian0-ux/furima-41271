class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/

  validates :password,
            format: {
              with: VALID_PASSWORD_REGEX
            },
            allow_nil: true

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  validates :last_name, :first_name,
            format: {
              with: VALID_NAME_REGEX
            }

  validates :last_name_kana, :first_name_kana,
            format: {
              with: VALID_KANA_REGEX
            }

  validates :date_of_birth, presence: true

  # Associations
  has_many :goods, dependent: :destroy
end
