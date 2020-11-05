require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:first_user) {FactoryBot.create :user, role: 1}

  describe "GET #update" do
    context "with valid user" do
      before do
        login_user first_user
        patch :update, params:{id: first_user.id}
      end
      it { should use_before_action(:find_user) }

      it "user.member? shouble be true" do
        expect(first_user.member!).to be true
      end

      it "display success message" do
        expect(flash[:notice]).to be_present
      end

      it "should redirect to categories_path" do
        expect(response).to redirect_to root_path
      end

      it "send email to sidekiq" do
        expect {SendMailUpgradeWorker.perform_async first_user.id}
          .to change(SendMailUpgradeWorker.jobs, :size).by(1)
      end
    end

    context "with invalid user" do
      before do
        login_user first_user
        patch :update, params:{id: "test"}
      end

      it "can not find user" do
        expect(flash[:alert]).to be_present
      end
    end
  end
end
