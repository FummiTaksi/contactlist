class User < ActiveRecord::Base
  has_many :contacts
  has_secure_password
  def to_s
    "#{username}"
  end
end
