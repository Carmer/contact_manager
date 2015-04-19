require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person)  { Person.new(first_name: "Alice", last_name: 'Smith') }

  it "is invalid without a first_name" do
    person.first_name = nil
    expect(person).not_to be_valid
  end
  it "is invalid without a last_name" do
    person = Person.new(first_name: "Andrew", last_name: nil)
    expect(person).not_to be_valid
  end

  it "is valid" do
    expect(person).to be_valid
  end

  it "has an array of phone numbers" do
    expect(person.phone_numbers).to eq([])
  end

  it "has an array of email_addresses" do
    expect(person.email_addresses).to eq([])
  end

  it 'responds with its created phone numbers' do
    person.phone_numbers.build(number: '555-8888')
    expect(person.phone_numbers.map(&:number)).to eq(['555-8888'])
  end

  it 'responds with its created email addresses' do
    person.email_addresses.build(address: 'me@example.com')
    expect(person.email_addresses.map(&:address)).to eq(['me@example.com'])
  end
end
