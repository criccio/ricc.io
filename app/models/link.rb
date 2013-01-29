class Link < ActiveRecord::Base
  validates :out_url, :http_status, :presence => true
  validates :in_url, :uniqueness => true
  validates :out_url, :uniqueness => true
  
  URL_PROTOCOL_HTTP = "http://"
  REGEX_LINK_HAS_PROTOCOL = Regexp.new('^http:\/\/|^https:\/\/', Regexp::IGNORECASE)
  
  def generate_short_url
	charset = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a 	
	(0...5).map{ charset[rand(charset.size)] }.join
  end

  # ensure the url starts with it protocol and is normalized
  def clean_out_url()
    return nil if self.out_url.blank?
   	self.out_url = URL_PROTOCOL_HTTP + self.out_url.strip unless self.out_url =~ REGEX_LINK_HAS_PROTOCOL
    self.out_url = URI.parse(self.out_url).normalize.to_s
  end
  
  #before_save :clean_out_url
  before_validation :clean_out_url
  
  def create
    count = 0
    begin
      if self.in_url.blank?
      	self.in_url = generate_short_url
      end
      super
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid => err
      if (count +=1) < 5
        logger.info("retrying with different unique key")
        retry
      else
        logger.info("too many retries, giving up")
        raise
      end
    end
  end
end
