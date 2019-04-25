class Work < ApplicationRecord
  # Must have a title
  validates :title, presence: true

  def self.index_media(media_type)
    collection = Work.where(category: media_type)
    return collection
  end

  def self.top_media(media_type)
    collection = Work.where(category: media_type).sample(10)
    return collection
  end

  def self.media_spotlight
    top_work = Work.all.sample
    return top_work
  end
end
