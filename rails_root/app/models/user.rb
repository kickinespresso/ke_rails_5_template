class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  scope :recent, -> num_users { where.not(last_sign_in_at: nil).order("last_sign_in_at ASC" ).limit(num_users) }
end
