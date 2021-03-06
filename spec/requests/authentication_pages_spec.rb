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
      it { should have_link('Users', href: users_path) }
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
    context "for non-signed-in users" do
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

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end        
      end

      context "in the Comments controller" do
        describe "submiting to the create action" do
          before { post comments_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submiting to the destroy action" do
          before { delete comment_path(FactoryGirl.create(:comment)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    context "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@gmail.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match('Edit user') }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user), {name: "Daniel", email: "newemail@gmail.com"} }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    context "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
