# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :index, Board, is_public: true
    # 全ユーザー（ログインなし含む）に公開ボードの閲覧権限を付与
    can :read, Board, is_public: true

    # ログインユーザー向けの追加権限設定
    return unless user.present?

    # ユーザー自身のボードに対する全権限を付与
    can :manage, Board, user_id: user.id

    # ユーザーは他のユーザーの非公開ボードは見れない（念のため明示的に拒否）
    cannot :read, Board, { is_public: false, user_id: !user.id }

    # 以下はコメントアウトされたデフォルト設定
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
