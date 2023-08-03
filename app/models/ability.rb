# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "admin"
      can :manage, :all
    else
      can :read, Post, Comment 
      can :create, [Comment, Post, Like]
      can :update, Post, author_id: user.id
      can :destroy, [Comment, Post], author_id: user.id
    end
  end
end
