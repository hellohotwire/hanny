class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_person_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :features
  has_many :votes
  has_many :comments
end
