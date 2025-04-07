class User < ApplicationRecord
  belongs_to :company
  has_many :tweets

  scope :by_company, -> (identifier) { where(company: identifier) if identifier.present? }
  scope :by_username, -> (username) { where('username LIKE ?', "%#{username}%") if username.present? }

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
