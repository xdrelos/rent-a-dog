class RentingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    record.user == user || record.dog.user == user # Only restaurant creator can update it
  end

  def destroy?
    record.user == user  # Only restaurant creator can update it
  end
end
