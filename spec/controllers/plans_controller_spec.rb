require "rails_helper"

RSpec.describe PlansController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:category) {FactoryBot.create :category}
  let!(:plans) {FactoryBot.create_list :plan, 10, user_id: user.id, category_id: category.id}
  let(:valid_params) {FactoryBot.attributes_for :plan, user_id: user.id, category_id: category.id, spending_category: "income"}
  let(:invalid_params) {FactoryBot.attributes_for :plan, user_id: user.id, category_id: category.id, moneys: 10}
  let(:expenses_params) {FactoryBot.attributes_for :plan, user_id: user.id, category_id: category.id, moneys: 6000, spending_category: "expenses"}

  before {login_user user}
  describe "GET #index" do
    before {get :index, params:{status: "", month: ""}}

    it "list all plans" do
      expect(assigns[:plans].size).to eq 10
    end
  end

  describe "GET #new" do
    before {get :new}
    it "is a new plan" do
      expect(Plan.new).to be_a_new(Plan)
    end

    it "is a new category" do
      expect(Category.new).to be_a_new(Category)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, params: {plan: valid_params}}
      subject {post :create, params: {plan: valid_params}}
      it "create a new subject success" do
        expect {subject}.to change(Plan, :count).by(1)
      end

      it "display success message" do
        expect(flash[:notice]).to be_present
      end

      it "redirects_to :action => :new_plan" do
        expect(subject).to redirect_to :new_plan
      end
    end

    context "with invalid attributes" do
      subject {post :create, params: {plan: invalid_params}}
      it "create a new subject fail" do
        expect {subject}.to change(Plan, :count).by(0)
      end

      it "renders the index template" do
        expect(subject).to render_template :new
      end
    end

    context "with expenses > balance" do
      before {post :create, params: {plan: expenses_params}}
      subject {post :create, params: {plan: expenses_params}}
      it "display success message" do
        expect(flash.now[:alert]).to be_present
      end

      it "render :new" do
        expect(subject).to render_template :new
      end

    end
  end
end
