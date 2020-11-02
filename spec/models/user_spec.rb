require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it { is_expected.to have_many(:categories) }
  end

  describe "#to_csv" do
    subject {User.to_csv}

    it {should include "full_name"}
    it {should include "email"}
    it {should include "activated"}
    it {should include "created_at"}
    it {should include "update_at"}
  end
end
