module Contact
  extend ActiveSupport::Concern

  included do
    has_many :email_addresses, as: :contact
    has_many :phone_numbers, as: :contact
  end

  module ClassMethods
  end

end
