class Person < ActiveRecord::Base
  validates :last_name, presence: true
  validates :first_name,  presence: true

  has_many :email_addresses, as: :contact
  has_many :phone_numbers, as: :contact
end
