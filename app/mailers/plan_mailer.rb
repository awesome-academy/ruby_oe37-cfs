class PlanMailer < ApplicationMailer
  default from: "cashflowmanagement@gmail.com"
  def plan_email user
    @user = user
    mail(to: @user.email, subject: "Plan Email")
  end
end
