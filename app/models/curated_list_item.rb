class CuratedListItem < ApplicationRecord
  belongs_to :curated_list, foreign_key: "curated_list_id"
  validates :prompt, presence: true
  validates :url, presence: true
end
