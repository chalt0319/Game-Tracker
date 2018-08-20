class Character < ActiveRecord::Base
  belongs_to :game
  has_many :abilities

  def self.delete_all
    self.all.each do |x|
      x.delete
    end
  end
end
