class HouseFoodPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(house: user.house)
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

end
