require 'spec_helper'

describe "Comment pages " do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "comment creation" do
    before { visit root_path }

    context "with invalid information" do
      it "should not create a comment" do
        expect { click_button "Post" }.not_to change(Comment, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content("error") }
      end
    end

    context "with valid information" do
      before { fill_in 'comment_content',with: "Lorem ipsum" }
      it "should create a comment" do
        expect { click_button "Post"}.to change(Comment, :count).by(1)
      end
    end
  end

  describe "comment destruction" do
    before { FactoryGirl.create(:comment, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a comment" do
        expect{ click_link "delete"}.to change(Comment, :count).by(-1)
      end
    end
  end
end
