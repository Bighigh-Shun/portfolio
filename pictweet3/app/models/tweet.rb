class Tweet < ApplicationRecord
  # ↓空の投稿ができないようにするもの。
  validates :text, presence: true

  belongs_to :user
end
