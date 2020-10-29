require "rails_helper"

RSpec.describe SharesController, type: :controller do
  let(:first_user) {FactoryBot.create :user}
  let(:second_user) {FactoryBot.create :user}
  let!(:first_category) {FactoryBot.create :category,
    user_id: first_user.id}
  let!(:second_category) {FactoryBot.create :category,
    user_id: second_user.id}
  let!(:first_plan) {FactoryBot.create :plan, user_id: first_user.id, category_id: first_category.id, month: 10}
  let!(:second_plan) {FactoryBot.create :plan, user_id: second_user.id, category_id: second_category.id, month: 11}
  let!(:share) {FactoryBot.create :share, from_user_id: first_user.id, to_user_id: second_user.id, month: 10 }
  let(:valid_params) {FactoryBot.attributes_for :share, to_user_id: first_user.id, month: 11}
  let(:invalid_params) {FactoryBot.attributes_for :share, to_user_id: nil, month: 11}

  before {login_user second_user}

  describe "GET #index" do
    before {get :index, params:{user_id: first_user.id, month: 10}, xhr: true}

    it "display plan has been shared" do
      expect(assigns(:plans)).to match_array([first_plan])
    end
  end

  describe "GET #new" do
    before {get :new}
    it "is a new plan" do
      expect(Share.new).to be_a_new(Share)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, params: {share: valid_params}}
      subject {post :create, params: {share: valid_params}}
      it "create a new subject success" do
        expect {subject}.to change(Share, :count).by(1)
      end

      it "display success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects_to :action => :new_share" do
        expect(subject).to redirect_to :new_share
      end
    end

    context "with invalid attributes" do
      subject {post :create, params: {share: invalid_params}}
      it "create a new subject fail" do
        expect {subject}.to change(Plan, :count).by(0)
      end

      it "renders the index template" do
        expect(subject).to render_template :new
      end
    end
  end

  describe "GET #get_month_from_user_shared" do
    before {get :get_month_from_user_shared, params: {from_user_id: 1}, format: :json}
    it "list all month by from_user_shared" do
      expect(response).to have_http_status(200)
    end
  end
end
