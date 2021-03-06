class User < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :favorite_movies, :through => :favorites, :source => :movie

  has_secure_password

  validates :name, :presence => true
  validates :password, :length => {:minimum => 4, :allow_blank => true}
  validates :email, :presence => true,
                    :format => /\A(\S+)@(.+)\.(\S+)\z/i,
                    :uniqueness => {:case_sensitive => false}
  validates :username, :presence => true,
                       :uniqueness => {:case_sensitive => false}

  scope :by_name, -> { order(:name => :asc) }
  scope :no_admins_by_name, -> { by_name.where(:admin => false) }

  # scope :released, -> { where("released_on <= ?", Time.now).order(:released_on => :desc) }
  # scope :hits, -> { where("total_gross >= 300000000").order(:total_gross => :desc) }
  # scope :flops, -> { where("total_gross < 50000000").order(:total_gross => :asc) }
  # scope :upcoming, -> { where("released_on > ?", Time.now).order(:released_on => :desc) }
  # scope :recent, ->(max=5) { released.limit(max) }
  # scope :rated, ->(rating) { where("rating = ?", rating) }

  def self.authenticate(email_or_username, password)
    user = User.find_by(:email => email_or_username) || 
           User.find_by(:username => email_or_username) 
    user && user.authenticate(password)
  end

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

end
