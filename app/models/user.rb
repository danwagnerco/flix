class User < ActiveRecord::Base
  has_secure_password

  validates :name, :presence => true
  validates :password, :length => {:minimum => 4, :allow_blank => true}
  validates :email, :presence => true,
                    :format => /\A(\S+)@(.+)\.(\S+)\z/i,
                    :uniqueness => {:case_sensitive => false}

end
