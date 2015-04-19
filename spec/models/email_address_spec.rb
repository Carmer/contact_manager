require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email_address) do
    EmailAddress.new(address: 'carmerandrew@gmail.com', contact_id: 1, contact_type: 'Person')
  end

  it "is valid" do
    expect(email_address).to be_valid
  end

  it "is invalid without an email address" do
    email_address = EmailAddress.new(address: nil, contact_id: 1, contact_type: 'Person')
    expect(email_address).not_to be_valid
  end

  it 'is invalid without a person_id' do
    email_address = EmailAddress.new(address: 'carmerandrew@gmail.com', contact_id: nil, contact_type: 'Person')
    expect(email_address).not_to be_valid
  end

end
