class IndexedGif < ActiveRecord::Base
  include ActionView::Helpers

  attr_accessible :caption, :individual_caption, :source_name, :source_url, :source_id, :tags, :url
  serialize :tags
  def safe_caption
    return sanitize caption, tags: %w(b u em strong h1 h2 h3 h4 h5 h6 p a), attributes: %w(href target)
  end
  def safe_individual_caption
    return sanitize individual_caption, tags: %w(b u em strong h1 h2 h3 h4 h5 h6 p a), attributes: %w(href target)
  end

end
