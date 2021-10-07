class RentingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.dog.user != user
  end

  def update?
    record.user == user && record.pending? # Only restaurant creator can update it
  end

  def validate?
    record.dog.user == user && record.pending?
  end

  def destroy?
    record.user == user  # Only restaurant creator can update it
  end
end
