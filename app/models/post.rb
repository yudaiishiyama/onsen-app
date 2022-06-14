require 'uri'
require 'net/http'
class Post < ApplicationRecord
  validates :address, presence: true
  validates :spring_quality, presence: true
  validates :description, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :comments,dependent: :destroy
  has_one_attached :image, dependent: :destroy

  after_validation :geocode

  private

  def geocode
    # logger.debug("geocode")
    uri = URI.escape('https://maps.googleapis.com/maps/api/geocode/json?address=' + address.gsub(' ',
                                                                                                 '') + "&key=#{ENV['GOOGLE_MAP_KEY']}")
    # logger.debug("#{uri}")
    # res = HTTP.get(uri)
    res = Net::HTTP.get_response(URI(uri))
    response = JSON.parse(res.body)
    # logger.debug("#{res.body}")
    # logger.debug("geocode end")
    self.latitude = response['results'][0]['geometry']['location']['lat']
    self.longitude = response['results'][0]['geometry']['location']['lng']
  end
end
