require 'rails_helper'

RSpec.describe Person, type: :model do
  it "is invalid without a first_name" do
    person = Person.new(first_name: nil)
    expect(person).not_to be_valid
  end
  it "is invalid without a last_name" do
    person = Person.new(first_name: "Andrew", last_name: nil)
    expect(person).not_to be_valid
  end
end
