class IndexedGif < ActiveRecord::Base
  include ActionView::Helpers
  include PgSearch

  pg_search_scope :search,
                  :against => [:caption, :individual_caption, :tags],
                  :using => {
                    :tsearch => {
                      :dictionary      => 'english',
                      :tsvector_column => 'tsv'
                    }
                  }




  multisearchable :against => [:caption, :individual_caption, :tags]

  attr_accessible :caption, :individual_caption, :source_name, :source_url, :source_id, :tags, :url
  after_initialize :initialize_second
  serialize :tags


  validate :will_be_searchable?









  def safe_caption
    return sanitize caption, tags: %w(b u em strong h1 h2 h3 h4 h5 h6 p a), attributes: %w(href target)
  end
  def safe_individual_caption
    return sanitize individual_caption, tags: %w(b u em strong h1 h2 h3 h4 h5 h6 p a), attributes: %w(href target)
  end


    def will_be_searchable?
      if caption.blank? and individual_caption.blank? and ( tags.nil? or tags.empty? )
        errors[:base] << "Must have either some tags or a caption"
        return false
      end
      return true
    end
  private
    def initialize_second
      self.tags ||= []
    end
end
