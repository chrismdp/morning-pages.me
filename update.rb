module MorningPages
  class Update
    include Mongoid::Document
    include Mongoid::Timestamps

    field :count, :type => Fixnum
    field :average_length, :type => Float

    validates_presence_of :count

    attr_accessible :count, :average_length

    embedded_in :user
  end
end
