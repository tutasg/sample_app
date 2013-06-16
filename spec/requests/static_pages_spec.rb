require 'spec_helper'

describe "Static pages" do

subject { page }
 let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
    before { visit root_path }
      it { should have_content('Sample App') }
      it { should have_selector('title',
	     text: full_title('') ) }
      it { should_not have_selector('title', text: full_title('home') ) }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        visit signin_path
	 sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end


    end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')

    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "sample app"
    page.should have_selector 'title', text: full_title('')
  end




  end
   
   describe "Help page" do
	before { visit help_path }
		it "should have the content 'Help'" do
		  page.should have_content('Help')
		end
    it "should have the right title" do
	page.should have_selector('title',
	     :text => "Ruby on Rails Tutorial Sample App | Help")
	end
	end

  describe "About page" do
	before { visit about_path }
    it "should have the content 'About Us'" do
      page.should have_content('About Us')
    end
    it "should have the right title" do
	page.should have_selector('title',
	     :text => "| About")
	end
 end

 describe "Contact page" do
	before { visit contact_path }
    it "should have the h1 'Contact'" do
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the title 'Contact'" do
      page.should have_selector('title', :text => "#{base_title} | Contact")
    end
  end


end
