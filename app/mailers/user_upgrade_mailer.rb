class UserUpgradeMailer < ApplicationMailer
  def upgrade_notification user
    mail(to: user.email, subject: t(".subject"))
  end
end
