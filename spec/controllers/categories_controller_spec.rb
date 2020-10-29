require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let!(:first_category) {FactoryBot.create :category, user_id: user.id}
  let!(:second_category) {FactoryBot.create :category, user_id: user.id}
  let(:valid_params) {FactoryBot.attributes_for :category, user_id: user.id}
  let(:invalid_params) {FactoryBot.attributes_for :category, name: nil}
  # before {login user}
  before {login_user user}
  describe "GET #index" do
    before {get :index, params: {page: 1}}
    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "assigns @categories" do
      expect(assigns(:categories).pluck(:id)).to eq [second_category.id, first_category.id]
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, params: {category: valid_params}, xhr: true}
      it "create a new subject success" do
        expect {post :create, params: {category: valid_params}, xhr: true}.to change(Category, :count).by(1)
      end
    end

    context "with invalid attributes" do
      before {post :create, params: {category: invalid_params}, xhr: true}
      it "create a new subject success" do
        expect {post :create, params: {category: invalid_params}, xhr: true}.to change(Category, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when delete success" do
      before {delete :destroy, params: {id: first_category.id}}
      it { should use_before_action(:find_category_id) }

      it "category.inactive? shouble be true" do
        expect(first_category.inactive!).to be true
      end

      it "should redirect to categories_path" do
        expect(response).to redirect_to categories_path
      end

      it "display success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with private method find_category_id" do
      before {delete :destroy, params: {id: "test"}}
      it "can not find category" do
        expect(flash[:warning]).to be_present
      end
    end
  end
end
