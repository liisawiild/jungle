class Sale < ApplicationRecord

  #AR Scope (can create custom methods that can be used and chained)
  def self.active
    #in the where brackets = SQL, and the last two variables = the parameters put into the statement
    where("sales.starts_on <=? AND sales.ends_on >=?", Date.current, Date.current)
  end


  # instance method used in the _sale partial
  def finished?
    ends_on < Date.today
  end

  def upcoming?
    self.starts_on > Date.today
  end

  def active?
    !upcoming? && !finished?
  end


end
