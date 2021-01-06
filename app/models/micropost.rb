class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 140 },
                      presence: true
  has_one_attached :image # 追記
  validate :image_size, :image_type

  private

  def image_size
    if image.present? && image.blob.byte_size > 5.megabytes
      errors.add(:image, 'は5MB以内にしてください')
    end
  end

  def image_type
    if image.present? && !image.blob.content_type.in?(%('image/jpeg image/jpg image/gif image/png image/bmp'))
      errors.add(:image, 'は画像形式でアップロードしてください')
    end
  end
end
