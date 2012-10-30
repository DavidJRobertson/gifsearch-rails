class Crawler
  GIF_MAX_WIDTH  = 1024
  GIF_MAX_HEIGHT = 768

  Tumblr.configure do |config|
    config.consumer_key = "AcHYlG5GaS9xf842H1RC8WF81cvAH9zqf7fvxGSrfHQSy7ksqO"
    config.consumer_secret = "SYfZQUh6kGgEG3zAtQwO9jJwGEDcVXBMRg1QUTRIMZqBqDHMUR"
  end

  $tumblr = Tumblr.new


  public

  def self.scour_account(baseurl, stoptime = nil)
    blog_info = $tumblr.blog_info(baseurl)
    return false if blog_info.nil? or blog_info.empty?

    post_count = blog_info['blog']['posts']
    puts post_count

    puts "Scouring account..."

    stoptime = stoptime.utc if stoptime

    (0..post_count).step(20) do |offset|
      puts "Offset is #{offset}"
      $tumblr.posts(baseurl, type: :photo, offset: offset)['posts'].each do |post|
        date = post['date'].to_time.utc
        if stoptime and date < stoptime
          return
        end
        process_post post
      end
    end

  end


  def self.process_post(post, force_no_source=false)
    #puts post.inspect
    unless (post.class == Hash and post['type'] == 'photo')
      return false
    end

    force_no_source = true if post['source_url'] == post['post_url']

    if(post['source_url'] && !force_no_source)
      # This isn't the original source of this post! Go get it from there.
      begin
      uri = URI(post['source_url'])

      return process_post(post, true) if uri.path == "" or uri.path == "/" # Bail out on malformed source URLs!

      baseurl = uri.host
      scour_todo_add baseurl if post['photos'].first['original_size']['url'].ends_with?(".gif")

      id = uri.path.split('/')[2].to_i
      return process_post(post, true) if id == post['id']

      data = $tumblr.posts(baseurl, limit: 1, id: id)
      return process_post(post, true) if data.empty? # Bail out if the source post either a/ doesn't exist any more or b/ was never a tumblr post

      return process_post(data['posts'].first)
      rescue
        return false
      end

    else
      # This is the original source of this post
      post['photos'].each do |photo|
        image = photo['original_size']

        unless image['url'].ends_with?(".gif")
          # Not a gif, discard
          next
        end

        if image['width'] > GIF_MAX_WIDTH or image['height'] > GIF_MAX_HEIGHT
          # Image too large, discard
          next
        end

        gif = IndexedGif.new
        gif.url                 = image['url']
        gif.source_url          = post['post_url']
        gif.source_name         = post['blog_name']
        gif.source_id           = post['id']
        gif.tags                = post['tags']
        gif.caption             = post['caption']
        gif.individual_caption  = photo['caption']

        gif.nsfw = true unless (post['tags'] & %w(nsfw NSFW porn naked penis sex vagina cock)).empty?

        begin
          gif.save
        rescue
          # Don't die if we already have this gif :P
        end

      end
    end
    return nil
  end

  def self.scour_todo_add(baseurl)
    begin
      source = Source.new
      source.base_url= baseurl
      source.save
    rescue
      return false
    end
  end
end