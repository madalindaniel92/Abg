require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
   @user = User.new(name: "Example User", email: "user@example.com",
                    password: "is_needed", password_confirmation: "is_needed")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }

  it { should be_valid }
  it { should_not be_admin }

  context "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  context "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.oo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to be_valid
      end
    end
  end

  context "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  context "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "remember_token" do
    before { @user.save }
    specify { expect(@user.remember_token).not_to be_blank }
  end
end
