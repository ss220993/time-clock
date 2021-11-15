class User < ActiveRecord::Base
  attr_accessor :remember_token
  PAGINATION_PER_PAGE = 2
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 365 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  has_one :time_sheet_entry
  has_many :time_entries, through: :time_sheet_entry
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def paginate_users(page)
      paginate(per_page: PAGINATION_PER_PAGE, page: page).order('created_at DESC')
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  def session_token
    remember_digest || remember
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
