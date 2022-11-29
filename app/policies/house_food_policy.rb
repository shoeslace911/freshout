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
    create?
  end

  def create?
    true
  end

  def eat?
    true
  end

  def destroy?
    true
  end

  def add?
    true
  end

  def scan?
    true
  end
end
