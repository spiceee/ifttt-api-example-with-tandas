class Thing < Sequel::Model
  attr_accessor :created_at

  def self.all
    [
      Thing.new(created_at: Time.parse("Jan 1")),
      Thing.new(created_at: Time.parse("Jan 2")),
      Thing.new(created_at: Time.parse("Jan 3")),
    ]
  end

  def self.create
    Thing.new.tap do |new_thing|
      new_thing.created_at = all.last.created_at + 1.day
      all.push(new_thing)
    end
  end

  def id
    created_at.to_i
  end

  def to_json
    {
      created_at: created_at.to_json,
      meta: { id: id, timestamp: created_at.to_i }
    }
  end

  def to_limited_json
    { id: id }
  end
end
