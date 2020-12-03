class Track < ApplicationRecord
  belongs_to :mixtape
  validates :youtube_url, presence: true
end
