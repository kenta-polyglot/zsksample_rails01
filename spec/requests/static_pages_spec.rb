require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it 'should get root' do
      get '/'
      expect(response).to have_http_status(200)
      expect(response.body).to include 'hello, world!'
    end

    it 'micropost index including pagination link' do
      get microposts_url
      assert_select 'div.pagination'
    end
  end
end
