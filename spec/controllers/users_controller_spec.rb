require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET #index' do
    it 'returns a list of users' do
      get :index
      expect(response).to be_successful
    end
  end
  describe 'filter by company' do
    it 'returns a list of users by company' do
      company = create(:company)
      user = create(:user, company: company)

      get :index, params: { company_identifier: company.id }

      expect(response).to be_successful
      expect(response.body).to include(user.username)
    end

    it 'and not have users with other company' do
      company = create(:company)
      company2 = create(:company)
      user = create(:user, company: company)
      user2 = create(:user, company: company2)

      get :index, params: { company_identifier: company.id }

      expect(response.body).to include(user.username)
      expect(response.body).not_to include(user2.username)
    end

  end

  describe 'filter by username' do
    it 'returns a list of users by username' do
      user = create(:user, username: 'test_user')
      
      get :index, params: { username: 'test_user' }

      expect(response).to be_successful
      expect(response.body).to include(user.username)
    end

    it 'and not have users with other username' do
      user = create(:user, username: 'test_user')
      user2 = create(:user, username: 'other_user')

      get :index, params: { username: 'test_user' }

      expect(response.body).to include(user.username)
      expect(response.body).not_to include(user2.username)
    end

    it 'and not have users' do
      get :index, params: { username: 'test_user' }
      
      expect(response.body).to eq("[]")
    end
  end
end