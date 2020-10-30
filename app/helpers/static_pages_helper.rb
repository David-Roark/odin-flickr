module StaticPagesHelper
  def img_url(i)
    "http://farm#{i.farm}.staticflickr.com/#{i.server}/#{i.id}_#{i.secret}.jpg"
  end
end
