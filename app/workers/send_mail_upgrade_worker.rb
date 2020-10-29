class SendMailUpgradeWorker
  include Sidekiq::Worker

  def perform user_id
    user = User.find user_id
    UserUpgradeMailer.upgrade_notification(user).deliver
  end
end
