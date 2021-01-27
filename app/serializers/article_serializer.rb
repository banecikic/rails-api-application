class ArticleSerializer
  include JSONAPI::Serializer
  attributes  :id, :title, :content, :slug
end
