require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it "is valid with a name and  an email" do
      user = User.new(name: "FooBar",
                     email: "foobar@example.com"
                     )
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = User.new(name: nil,
                     email: "foobar@example.com"
                     )
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")                 
    end

    it "is invalid without an email " do
      user = User.new(name: "Foobar",
                     email: nil
                     )
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")   
    end

    it "is invalid with a duplicate email address" do
      User.create(name: "FooBar",
                 email: "foobar@example.com"
                 )
      user = User.new(name: "YoheiYasukawa",
                     email: "foobar@example.com"
                     )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")   
    end

    it "is invalid with too long name" do
      user = User.new(name: "a" * 51,
                     email: "foobar@example.com"
                     )
      expect(user.valid?).to be_falsey
    end

    # it "is invalid withiout valid address" do
    #   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    #                      first.last@foo.jp alice+bob@baz.cn]
    #   valid_addresses.each do |valid_address|
    #     user = User.new(name: "Foobar",
    #                    email: valid_address
    #                    )
    #     assert user.valid?, "#{valid_address.inspect} should be valid"
    #   end
    # end

  end
end
