require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'scope by_company' do
    it 'returns users by company' do
      company = create(:company)
      user = create(:user, company: company)
      expect(User.by_company(company.id)).to include(user)
    end
  end

  describe 'scope by_username' do
    it 'returns users by username' do
      user = create(:user, username: 'test_user')
      expect(User.by_username('test_user')).to include(user)
    end
  end
end
