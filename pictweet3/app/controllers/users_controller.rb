class UsersController < ApplicationController
  def show
    # @nickname = current_user.nickname
    # @tweets = current_user.tweets
    # ↑ 誰でもその人のマイページを見れるようにするため変更。
    # 「current_user」だと、ログインしているその人のページに飛んでしまう。

    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets
  end
end
