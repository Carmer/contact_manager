require 'rails_helper'

describe 'the company view', type: :feature do

  let(:company) { Company.create(name: 'abcCompany') }

  describe 'email addresses' do
    before(:each) do
      company.email_addresses.create(address: 'abc@gmail.com', contact_id: company.id, contact_type: 'Company')
      company.email_addresses.create(address: 'abcc@ymail.com', contact_id: company.id, contact_type: 'Company')
    end

    before(:each) do
      company.phone_numbers.create(number: '555-1234')
      company.phone_numbers.create(number: '555-9876')
      visit company_path(company)
    end

    it "shows the phone numbers" do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it "has a link to add a new phone number" do
      expect(page).to have_link("Add Phone Number", href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add Phone Number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has a link to add another' do
      expect(page).to have_link('Add Phone Number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'has a link to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).not_to have_content(old_number)
    end

    it 'deletes a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'delete number').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
    end

    it 'deletes all numbers and they are really gone from db' do
      first(:link, 'delete number').click
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('delete')
      first(:link, 'delete number').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content('delete number')
    end

    it 'has email addresses' do
      company.email_addresses.each do |email_address|
        expect(page).to have_selector('li', text: email_address.address)
      end
    end

    it "has a link to create email addresses" do
      expect(page).to have_link('Add Email Address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
    end

    it "can create a new email address" do
      page.click_link('Add Email Address')
      page.fill_in('Address', with: 'JJ@gmail.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("JJ@gmail.com")
    end


  end
end
