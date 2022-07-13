require 'uri'
require 'net/http'
class Post < ApplicationRecord
  validates :address, presence: true
  validates :spring_quality, presence: true
  validates :description, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  
  def self.search(search)
    if search != ""
      Post.where('address LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

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
