class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  
  has_one :about, dependent: :destroy
  has_one :mission_statement, dependent: :destroy
  has_many :photo_albums, dependent: :destroy
  has_many :packages, dependent: :destroy
end
