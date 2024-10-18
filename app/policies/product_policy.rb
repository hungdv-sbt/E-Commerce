class ProductPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
