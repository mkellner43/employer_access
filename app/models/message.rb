class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  has_one_attached :attachment

  validate :validate_attachment_filetypes

  private

  def validate_attachment_filetypes
    return unless attachment.attached?

    unless attachment.byte_size <= 5.megabyte
      errors.add(:attachment, "is too big")
    end

    unless attachment.content_type.in?(%w(image/jpeg image/png image/gif application/pdf))
      errors.add(:attachment, "must be an image")
    end
  end
end
