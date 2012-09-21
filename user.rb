module MorningPages
  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    attr_accessible :email, :username

    field :username, :type => String
    field :email, :type => String
    field :key, :type => String

    validates_format_of :email, :with => /@/
    validates_presence_of :email, :username
    validates_uniqueness_of :username

    embeds_many :updates

    before_save do |document|
      document.key = SecureRandom.uuid
    end
  end
end
