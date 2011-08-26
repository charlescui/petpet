class Provider < ActiveRecord::Base
  #新浪QQ等第三方认证
  belongs_to  :user

  def consumer
    app_key, app_secret, opts = Rca::Application.config.omniauth[self.provider.to_sym]
    OAuth::Consumer.new(app_key, app_secret, { :site => opts[:site] })
  end

  def access_token
    OAuth::AccessToken.from_hash(consumer, { :oauth_token => self.token, :oauth_token_secret => self.secret })
  end

  # 将自己所有发出的feed发微博
  def status_update(str)
    case self.provider
    when "tsina"
      url = "http://api.t.sina.com.cn/statuses/update.json"
      access_token.delay.request(:post,url,{:status => str})
    when "renren"
    else
      raise ArgumentError, "no support."
    end
  end

  # 获取msn联系人信息
  # 目前没办法通过live开放的api得到联系人邮箱
  def import_msn_contact
    case self.provider
    when "liveid"
      contact_url = "https://apis.live.net/v5.0/me/contacts"
      usr_url = "https://apis.live.net/v5.0/"
      access_token.request(:get,contact_url+"?access_token=#{self.token}")
    else
      raise ArgumentError, "no support."
    end
  end

  def import_sina_friend_ids(cursor = -1)
    uids = []
    rsp = access_token.request(:get, "http://api.t.sina.com.cn/friends/ids.json?cursor=#{cursor}&count=5000")
    data = ActiveSupport::JSON.decode(rsp.body)
    if data["next_cursor"] != 0
      uids += import_sina_friend_ids(cursor+1)["ids"]
    else
      return uids
    end
  end

  # 这些好友是用户在新浪微博上的好友（关注的人），
  # 并且开通了本网站功能
  def friends_from_sina(uids=import_sina_friend_ids)
    friends = []
    case uids.class.to_s
      when Array.to_s
        Provider.where(["uid in ?", uids])
        uids.each { |uid|
          friends << Provider.find_by_uid(uid).user
        }
      when String.to_s
        friends = Provider.find_by_uid(uid).user
    end
    friends.compact
  end

  def self.create_from_omniauth(hash)
    provider = self.build_from_omniauth(hash)
    provider.save!
    provider
  end

  def self.build_from_omniauth(hash)
    provider = Provider.new(:provider => hash['provider'], :uid => hash['uid'])
    case provider.provider
    when 'tsina'    
      provider.token = hash["credentials"]["token"]
      provider.secret = hash["credentials"]["secret"]
    when 'renren'  
      provider.token = hash["credentials"]["token"]
      provider.secret = hash["credentials"]["secret"]
    when 'liveid'
      provider.token = hash["credentials"]["token"]
      provider.secret = hash["credentials"]["refresh_token"]
    else
      provider.token = hash["credentials"]["token"]
      provider.secret = hash["credentials"]["secret"]
    end
    provider.metadata = hash["user_info"]
    provider
  end

  def self.auth(hash)
    provider = self.find_by_provider_and_uid(hash["provider"],hash["uid"])
    if provider
      provider.token = hash["credentials"]["token"]
      provider.secret = hash["credentials"]["secret"]
      provider.save!
    end
    provider
  end

  # metadata保存hash后的object
  def metadata
    data = self.read_attribute(:metadata)
    if data.class == Hash
      data
    else
      YAML.load(data)
    end
  end

end

# == Schema Information
#
# Table name: providers
#
#  id         :integer(4)      not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  token      :string(255)
#  secret     :string(255)
#  user_id    :integer(4)
#  metadata   :binary
#  created_at :datetime
#  updated_at :datetime
#

