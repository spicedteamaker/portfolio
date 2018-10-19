class User < ApplicationRecord

  # docs for enums: https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
  enum role: [:basic, :operator, :admin]

  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
