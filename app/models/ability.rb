class Ability
  include CanCan::Ability

  def initialize(user)


    # Define abilities for the passed in user here. For example:
      user ||= User.new(role: 3) # guest user (not logged in)
       if user.admin?
         can :manage, :all
        elsif user.editor?
            can :read, :all
            can :create, :all
            can :edit, [:post, :comment]
            can :destroy, [:post, :comment], user_id: user.id
            can [:set_tag, :set_tags], Post
            can :like, [:post, :comment]
        elsif user.user?
            can :read, :all
            can :create, [:post, :comment]
            can [:edit, :destroy], [:post, :comment], user_id: user.id
            can :set_tag, Post, user_id: user.id
            can :like, [:post, :comment]
       else
         can :read, :all
       end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
