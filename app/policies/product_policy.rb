class ProductPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def publishable?
    user.admin?
  end
end
