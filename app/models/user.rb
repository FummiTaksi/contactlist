class User < ActiveRecord::Base
  has_many :contacts

  def to_s
    "#{username}"
  end
end
