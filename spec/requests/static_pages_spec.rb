require 'spec_helper'

describe "Static Pages" do

  subject { page }

  shared_examples_for "all static pages" do
  	it { should have_content(heading) }
  	it { should have_title(page_title) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { 'Sample App' }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help page" do
  	before { visit help_path }

  	let(:heading) { 'Help' }
  	let(:page_title) { 'Help' }
  end

  describe "About page" do
  	before { visit about_path }
  	
  	it { should have_selector('h1', text: 'About') }
  	it { should have_title('About') }
  end

  describe "Contact page" do
  	before { visit contact_path }

  	it { should have_selector('h1', text: 'Contact') }
  	it { should have_title('Contact') }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:ml) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:ml) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end

  it "should have the right links on the layout" do
  	visit root_path
  	click_link "About"
  	expect(page).to have_title('About')
  	click_link "Help"
  	expect(page).to have_title('Help')
  	click_link "Contact"
  	expect(page).to have_title('Contact')
  	click_link "Home"
  	click_link "Sign up now!"
  	expect(page).to have_title('Sign')
  	click_link "sample app"
  	# expect(page).to have_title('Home')
  end
end
