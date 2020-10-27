require "rails_helper"

RSpec.describe Share, type: :model do
  let(:from_user) {FactoryBot.create :user}
  let!(:to_user) {FactoryBot.create :user}
  let!(:share) {FactoryBot.create :share, from_user_id: from_user.id, to_user_id: to_user.id }

  describe "Associations" do
    it { should belong_to(:from_user) }
    it { should belong_to(:to_user) }
  end

  describe "Scope" do
    it "returns a share where by where_by_from_user_id" do
      expect(Share.where_by_from_user_id(from_user.id)).to be_present
    end

    it "returns a share where by where_by_to_user_id" do
      expect(Share.where_by_to_user_id(to_user.id)).to be_present
    end
  end
end
