class TweetsController < ApplicationController

  # ↓ ７つのアクションで共通のものをまとめた。
  # 「set_tweet」というメソッドをプライベートメソッドに記述して、
  # 「edit」「show」アクションにのみ適用する
  before_action :set_tweet, only: [:edit, :show]

  # ↓未ログインのユーザーが直接アクセスしてきても、ルートパスに遷移するもの。
  # 「move_to_index」というメソッドをプライベートメソッドに記述して、
  # 「index」「show」アクション以外に適用する
  before_action :move_to_index, except: [:index, :show]

  def index
    # @tweets = Tweet.all
    # ↑ 「N+1」問題が発生するので、"include"メソッドで解決する ↓
    @tweets = Tweet.includes(:user)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
  end

  private

  # ↓ストロングパラメーター。許可したパラメーターだけ受け取るようにしたもの。
  def tweet_params
    # params.require(:tweet).permit(:name, :image, :text).merge(user_id: current_user.id)
    # permit()内の「:name」を削除した。userモデルとアソシエーションを組み、ニックネームを表示するようにしたので、受け取る必要がなくなった。
    # 併せて、「tweetsテーブル」の「name」カラムも削除。
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  # ↓共通の処理。リファクタリング。
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # ↓ルートパスに遷移する。未ログインの人対策。
  # 「action: :index」= tweet.controller の indexアクション。
  # unless文。判定式が偽（false）の時に動く。if文と真逆。
  # ここでは、「user_signed_in?」の判定が偽（= ログインしていない）場合に、
  # 「redirect_to action: :index」が実行される。

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end



end
