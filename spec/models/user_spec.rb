require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it '有効なファクトリを持つこと' do
    expect(user.valid?).to eq true
  end

  describe 'バリデーション' do
    context 'name' do
      it 'presense :true' do
        user.name = ''
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end

      it 'length: {maximum: 20}' do
        user.name = 'a' * 21
        user.valid?
        expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
      end
    end

    context 'password' do
      it 'maximum: 30' do
        user.password = 'a' * 31
        user.valid?
        expect(user.errors[:password]).to include("is too long (maximum is 30 characters)")
      end

      it 'minimum: 6' do
        user.password = 'a' * 5
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end
  end
end
