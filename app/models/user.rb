class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  validates_presence_of :login, :first_name, :last_name
  validates_length_of :login,      :maximum => 50
  validates_length_of :first_name, :maximum => 50
  validates_length_of :last_name,  :maximum => 50

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.new(first_name: data["given_name"],
                        last_name:  data["family_name"],
                        login:      data["name"],
                        email:      data["email"],
                        password:   Devise.friendly_token[0,20])
        user.confirm!
        user.save!
    end
    user
end

end
