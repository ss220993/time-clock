require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create user' do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end

    it 'when user create is successful' do
      saved_user = @user.save
      expect(saved_user).to be true
    end

    it 'when user create is un successful when email is invalid' do
      @user.email = 's'
      saved_user = @user.save
      expect(saved_user).to be false
    end

    it 'when user create is un successful when password is invalid' do
      @user.password = nil
      saved_user = @user.save
      expect(saved_user).to be false
    end

    it 'when user create is un successful when password is invalid' do
      @user.password = 'abc'
      saved_user = @user.save
      expect(saved_user).to be false
    end
  end
end
