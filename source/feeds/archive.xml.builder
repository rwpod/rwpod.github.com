# frozen_string_literal: true

get_rss_articles(limit: 500).each do |article|
  xml.item do
    xml.title article.title
    xml.description do
      xml.cdata! article.body
    end
    xml.pubDate article.date.to_s(:rfc822)
    xml.link full_url(article.url)
    xml.guid({ isPermaLink: 'true' }, full_url(article.url))

    if article.data.audio_url && article.data.audio_length
      xml.enclosure(url: article.data.audio_url, length: article.data.audio_length,
type: (article.data.audio_format || 'audio/mpeg'))
      xml.media :content, url: article.data.audio_url, fileSize: article.data.audio_length,
type: (article.data.audio_format || 'audio/mpeg')

      if article.data.audio_mirror
        xml.media :content, url: article.data.audio_mirror, fileSize: article.data.audio_length,
type: (article.data.audio_format || 'audio/mpeg')
      end

    end

    xml.itunes :author, default_author_helper
    xml.itunes :subtitle, truncate(Nokogiri::HTML(article.body).text, length: 150)
    xml.itunes :summary, Nokogiri::HTML(article.summary).text
    xml.itunes :image, href: (article.data.main_image ? full_url(article.data.main_image) : default_image_helper)
    xml.itunes :duration, (article.data.duration || '00:30:00')

    xml.creativeCommons :license, 'http://creativecommons.org/licenses/by-nc-nd/4.0/'
    xml.media :copyright, 'Creative Commons - Attribution-NonCommercial-NoDerivatives 4.0 International.', url: 'http://creativecommons.org/licenses/by-nc-nd/4.0/'
  end
end
