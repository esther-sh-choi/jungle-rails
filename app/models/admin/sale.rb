class Admin::Sale < ApplicationRecord

    # Creating an active record scope to make it easy to query sales
    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :percent_off, presence: true, numericality: true
  
    def self.active
      where("sales.start_date <= ? AND sales.end_date >= ?", Date.current, Date.current)
    end
  
    def finished?
      end_date < Date.current
    end
  
    def upcoming?
      start_date > Date.current
    end
  
    def active?
      !upcoming? && !finished?
    end

  
end
