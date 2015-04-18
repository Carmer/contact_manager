require 'spec_helper'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  describe 'email addresses' do
    before(:each) do
      person.email_addresses.create(address: 'jjd@gmail.com')
      person.email_addresses.create(address: 'jjddddd@ymail.com')
    end

    before(:each) do
      person.phone_numbers.create(number: '555-1234')
      person.phone_numbers.create(number: '555-9876')
      visit person_path(person)
    end

    it "shows the phone numbers" do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end
    it "has a link to add a new phone number" do
      expect(page).to have_link("Add Phone Number", href: new_phone_number_path(person_id: person.id))
    end
    it 'adds a new phone number' do
      page.click_link('Add Phone Number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'has a link to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).not_to have_content(old_number)
    end

    it 'deletes a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(old_number)
    end

    it 'deletes all numbers and they are really gone from db' do
      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('delete')
      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content('delete')
    end

    it 'has email addresses' do
      person.email_addresses.each do |email_address|
        expect(page).to have_selector('li', text: email_address.address)
      end
    end

    it "has a link to create email addresses" do
      expect(page).to have_link('Add Email Address', href: new_email_address_path(person_id: person.id))
    end

    it "can create a new email address" do
      page.click_link('Add Email Address')
      page.fill_in('Address', with: 'JJ@gmail.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content("JJ@gmail.com")
    end


  end
end
