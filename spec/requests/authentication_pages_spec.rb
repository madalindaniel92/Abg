require 'rails_helper'

describe "Authentication" do
  
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content("Sign in") }
  end

  describe "signin" do
    before { visit signin_path }
    let(:submit) { "Sign in" }

    context "with invalid information" do
      before { click_button submit }

      it { should have_selector('div.alert.alert-error') }

      context "after visiting another page" do
        before { click_link 'Home' }
        it { should_not have_selector('.div.alert.alert-error') }
      end
    end

    context "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button submit
      end

      it { should have_content(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signin_path) }
      it { should_not have_link('Sign in') }

      context "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
    end
  end

  describe "authorization" do
    context "non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      context "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_content("Sign in") }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end
end
