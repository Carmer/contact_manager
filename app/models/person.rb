class Person < ActiveRecord::Base
  include Contact
  validates :last_name, presence: true
  validates :first_name,  presence: true

end
