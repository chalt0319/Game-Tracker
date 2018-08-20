class Game < ActiveRecord::Base
  belongs_to :user
  has_many :characters

  def self.delete_all
    self.all.each do |x|
      x.delete
    end
  end
end
