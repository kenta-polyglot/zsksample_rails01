class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 140 }, # 140文字の文字数制限
                      presence: true # マイクロポストのコンテンツの存在確認
end
