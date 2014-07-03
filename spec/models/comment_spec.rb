require 'spec_helper'

RSpec.describe Comment, :type => :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:comment) { user.comments.build(content: "Lorem ipsum") }

  subject { comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it "should have the right user" do
    expect(comment.user).to equal(user)
  end

  it { should be_valid }

  describe "when user_id is not present" do
    before { comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blanck content" do
    before { comment.content = " " }
    it { should_not be_valid }    
  end

  describe "with content that is too long" do
    before { comment.content = "a" * 141 }
    it { should_not be_valid }    
  end
end
