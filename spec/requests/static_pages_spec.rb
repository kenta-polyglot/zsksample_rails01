require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it 'should get root' do
      get '/'
      expect(response).to have_http_status(200)
      expect(response.body).to include 'hello, world!'
    end

    it 'user index including pagination link' do
      50.times do |n|
        name  = Faker::Name.name
        email = "example-#{n + 1}@railstutorial.org"
        User.create!(name: name, email: email)
      end
      get users_url
      assert_select 'div.pagination'
    end
  end
end
