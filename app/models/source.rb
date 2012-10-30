class Source < ActiveRecord::Base
  attr_accessible :base_url, :last_crawled, :nsfw
  after_create :crawl


  def crawl
    Crawler.delay.scour_account(self.base_url, self.last_crawled)
    self.last_crawled = Time.now
    self.save
  end

end
