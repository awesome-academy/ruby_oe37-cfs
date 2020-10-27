require "rails_helper"

RSpec.describe Plan, type: :model do
  let!(:user) {FactoryBot.create :user}
  let!(:first_plan) {FactoryBot.create :plan, status: 0, month: 10, user_id: user.id}
  let!(:second_plan) {FactoryBot.create :plan,status: 1, month: 11, user_id: user.id}

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
  end

  describe "Enums" do
    it { should define_enum_for(:spending_category) }
    it { should define_enum_for(:type_money) }
    it { should define_enum_for(:status) }
  end

  describe "Validations" do
    it { should validate_presence_of(:moneys) }
    it { should validate_numericality_of(:moneys).is_greater_than_or_equal_to(Settings.min_money) }
  end

  describe "Scope" do
    it "returns a plan where by month equal 10" do
      expect(Plan.where_by_month(10)).to be_present
    end

    it "returns all plans where by month equal " " " do
      expect(Plan.where_by_month(" ")).to match_array [first_plan,second_plan]
    end

    it "returns a plan where by status equal (0 = confirm)" do
      expect(Plan.where_by_status(0)).to be_present
    end

    it "returns a plans where by status equal (1 = unconfirm)" do
      expect(Plan.where_by_status(1)).to be_present
    end

    it "returns all plans where by status equal " " " do
      expect(Plan.where_by_status(" ")).to match_array [first_plan,second_plan]
    end
  end

  describe "Delegate" do
    it { should delegate_method(:name).to(:category)
      .with_prefix(:category).allow_nil }
  end

  describe "Class method" do
    it ".spending_category_option" do
      expect(Plan.spending_category_option).to match_array [["Income", "income"], ["Expenses", "expenses"]]
    end

    it ".type_option" do
      expect(Plan.type_option).to match_array [["Fixed", "fixed"], ["Incurred", "incurred"]]
    end

    it ".status_option" do
      expect(Plan.status_option).to match_array [["Confirm", "confirm"], ["Unconfirm", "unconfirm"]]
    end

    it ".status_option_search" do
      expect(Plan.status_option_search).to match_array [["Confirm", 0], ["Unconfirm", 1]]
    end
  end
end
