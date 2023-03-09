class Sale < ApplicationRecord
  # Creating an active record scope to make it easy to query sales
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
