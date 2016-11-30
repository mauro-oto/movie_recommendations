require 'spec_helper'

describe User do
  let(:user_attrs) do
    {
      name: "Example User",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme" 
    }
  end

  it "should create a new instance given a valid attribute" do
    user = User.new(user_attrs)
    expect do
      user.save
    end.to change(User, :count).by(1)
  end

  it "should require an email address" do
    no_email_user = User.new(user_attrs.merge(email: ""))
    expect(no_email_user).not_to be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.foo user@foo.bar user@foo.baz]
    addresses.each do |address|
      valid_email_user = User.new(user_attrs.merge(email: address))
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,bar user.foo foo@bar.]
    addresses.each do |address|
      invalid_email_user = User.new(user_attrs.merge(email: address))
      expect(invalid_email_user).to be_valid
    end
  end

  it "should reject duplicate email addresses" do
    FactoryGirl.create(:user, user_attrs)
    user_with_duplicate_email = User.new(user_attrs)
    expect(user_with_duplicate_email).not_to be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = user_attrs[:email].upcase
    FactoryGirl.create(:user, user_attrs.merge(email: upcased_email))
    user_with_duplicate_email = User.new(user_attrs)
    expect(user_with_duplicate_email).not_to be_valid
  end

  describe "passwords" do
    let(:user) { User.new(user_attrs) }

    it "should have a password attribute" do
      expect(user).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(user).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      user = User.new(user_attrs.merge(password: "", password_confirmation: ""))
      expect(user).not_to be_valid
    end

    it "should require a matching password confirmation" do
      user = User.new(user_attrs.merge(password_confirmation: "invalid"))
      expect(user).not_to be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = user_attrs.merge(password: short, password_confirmation: short)
      user = User.new(hash)
      expect(user).not_to be_valid
    end
  end

  describe "password encryption" do
    let(:user) { FactoryGirl.create(:user, user_attrs) }

    it "should have an encrypted password attribute" do
      expect(user).to respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      expect(user.encrypted_password).not_to be_blank
    end
  end
end
