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
