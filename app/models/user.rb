class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates_presence_of :login, :first_name, :last_name
  validates_length_of :login,      :maximum => 50
  validates_length_of :first_name, :maximum => 50
  validates_length_of :last_name,  :maximum => 50

end
