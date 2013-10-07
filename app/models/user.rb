class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  devise :omniauthable, :omniauth_providers => [:google_oauth2, :twitter]

  has_attached_file :avatar,
                    :styles => { large: "400x400#", medium: "300x300#",
                                 :small => "100x100#", thumb: "50x50#" }

  has_one :plan

  validates_presence_of :login, :first_name, :last_name
  validates_uniqueness_of :login
  validates_length_of :login,      :maximum => 50
  validates_length_of :first_name, :maximum => 50
  validates_length_of :last_name,  :maximum => 50

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    #Use email as login
    user = User.where(:login => data["email"]).first

    unless user
      user = User.new(first_name: data["given_name"],
                      last_name:  data["family_name"],
                      login:      data["email"],
                      email:      data["email"],
                      password:   Devise.friendly_token[0,20])
      user.confirm!
      user.save
    end
    user
  end

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    #Use screen_name as login
    user = User.where(:login => data["screen_name"]).first

    unless user
      name_split = data["name"].split(" ")
      user = User.new(first_name: name_split[0],
                      last_name:  name_split[1],
                      login:      data["screen_name"],
                      password:   Devise.friendly_token[0,20])
      user.confirm!
      user.save
    end
    user
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(login) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # bypass re-entering current password for edit
  def update_with_password(params={})
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

end
