require "spec_helper"

describe User do
  describe "should have mandatory fields" do
    it "validate email" do
      user = User.new(email: "raj")
      user.save
      expect(user.errors.keys).to include(:email)
      expect(user.persisted?).to be_false
    end

    it "create new user" do
      user = User.new
      user.role_id = 2
      user.email = "raj@yopmail.com"
      user.password = "abcdefgh"
      user.save 
      expect(user.persisted?).to be_true
    end
  end
end
