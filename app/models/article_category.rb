class ArticleCategory < ActiveRecord::Base
  belongs_to :article_id
  belongs_to :category 
end
