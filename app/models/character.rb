class Character < ActiveRecord::Base
  belongs_to :user
  has_many :abilities

  def self.delete_all
    self.all.each do |x|
      x.delete
    end 
  end
end
