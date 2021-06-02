class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category

  validates :article_id, uniqueness: { scope: [:article_id, :category_id] }
end