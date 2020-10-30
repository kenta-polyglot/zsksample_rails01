require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  fixtures :users
  fixtures :microposts

  it 'should be vaild' do
    user = User.new(name: 'hoge', email: 'hoge@gmail.com')
    expect(user).to be_valid
  end

  it 'name should be present' do
    user = User.new(name: '', email: 'hoge@gmail.com')
    expect(user).not_to be_valid
  end

  it 'name should be not be too long' do
    user = User.new(name: 'a' * 51, email: 'hoge@gmail.com')
    expect(user).not_to be_valid
  end

  it 'email should be present' do
    user = User.new(name: 'hoge', email: '')
    expect(user).not_to be_valid
  end

  it 'email should be not be too long' do
    user = User.new(name: 'hoge', email: 'a' * 244 + '@example.com')
    expect(user).not_to be_valid
  end

  it 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com
                         USER@foo.COM
                         A_US-ER@foo.bar.org
                         first.last@foo.jp
                         alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user = User.new(name: 'hoge', email: valid_address)
      expect(user).to be_valid
    end
  end

  it 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com
                           user_at_foo.org
                           user.name@example.
                           foo@bar_baz.com
                           foo@bar+baz.com
                           foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user = User.new(name: 'hoge', email: invalid_address)
      expect(user).not_to be_valid
    end
  end

  it 'email addresses should be unique' do
    user = User.new(name: 'hoge', email: 'hoge@gmail.com')
    duplicate_user = user.dup
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it 'email addresses should be saved as lower-case' do
    user = User.new(name: 'hoge', email: 'hoge@gmail.com')
    mixed_case_email = 'HogE@GmaiL.coM'
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it 'associated microposts should be destroyed' do
    user = User.new(name: 'hoge', email: 'hoge@gmail.com')
    user.save
    user.microposts.create!(content: 'Foobar')
    expect { user.destroy }.to change { Micropost.count }.by(-1)
  end

  it 'user should be associated to many microposts' do
    user = users(:Hoge)
    expect(user.microposts.count).to eq 34
  end
end
