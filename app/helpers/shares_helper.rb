module SharesHelper
  def get_all_users
    @users = User.where.not(id: current_user)
  end

  def is_shared?
    @shareds = Share.where to_user_id: current_user.id
    @shareds.first.to_user_id == current_user.id if @shareds.present?
  end

  def users_shared_option
    @shareds = Share.includes(:from_user).where(to_user_id: current_user)
    @shareds.map{|key| [key.from_user.email, key.from_user.id]}.uniq
  end
end
