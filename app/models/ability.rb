class Ability < ActiveRecord::Base
  belongs_to :character

  def self.delete_all
    self.all.each do |x|
      x.delete
    end
  end
  
end
