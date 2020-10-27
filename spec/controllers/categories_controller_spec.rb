require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let(:user) {FactoryBot.create(:user, :user)}
  let!(:first_category) {FactoryBot.create :category, user_id: user.id}
  let!(:second_category) {FactoryBot.create :category, user_id: user.id}
  let(:valid_params) {FactoryBot.attributes_for :category, user_id: user.id}
  let(:invalid_params) {FactoryBot.attributes_for :category, name: nil}
  let(:inactive) {FactoryBot.create :category, delete_flag: 1, user_id: user.id}
  before {login user}

  describe "before action" do
    it { should use_before_action(:find_category_id) }
    it { should use_before_action(:load_categories_of_user) }
  end

  describe "GET #index" do
    before { get :index }
    it { expect(response).to have_http_status(:success) }
    it { should render_template("index") }
    it { expect(assigns(:category)).to be_a_new(Category) }

    it "assigns @categories" do
      expect(assigns(:categories).pluck(:id)).to eq [second_category.id, first_category.id]
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        post :create, params: {category: valid_params}
      end
      it "create a new category success" do
        expect {post :create, params: {category: valid_params}}.to change(Category, :count).by(1)
      end
      it "flash success" do
        expect(flash[:success]).to eq I18n.t("category.success")
      end
    end

    context "with invalid attributes" do
      before do
        post :create, params: {category: invalid_params}
      end
      it "create a new category fail" do
        expect {post :create, params: {category: invalid_params}}.to change(Category, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when delete success" do
      before {delete :destroy, params: {id: first_category.id}}
      before {delete :destroy, params: {id: inactive.id}}
      it "category.activate? shouble be true" do
        expect(first_category.activate?).to be true
      end

      it "category.activate? shouble be false" do
        expect(inactive.activate?).to be false
      end

      it "should redirect to categories_path" do
        expect(response).to redirect_to categories_path
      end

      it "display success message" do
        expect(flash[:success]).to be_present
      end

      it "display fail message" do
        expect(flash[:danger]).to be_present
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
