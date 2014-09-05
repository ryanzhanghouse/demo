require 'spec_helper'

describe "Static Pages" do

  #let(:base_title) { "Ruby on Rails Tutorial" }

  describe "Home page" do
    it "should have the right title" do
      visit root_path
      expect(page).to have_title("Home")
    end
  end

  describe "Help page" do
  	it "should have the right title" do
  	  visit help_path
  	  expect(page).to have_title("Help")
  	end
  end

  describe "About page" do
  	it "should have the right title" do
  	  visit about_path
  	  expect(page).to have_title("About")
  	end
  end

  describe "Contact page" do
  	it "should have the right title" do
  	  visit contact_path
  	  expect(page).to have_title("Contact")
  	end
  end
end
