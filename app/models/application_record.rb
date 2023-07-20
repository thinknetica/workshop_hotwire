class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def random
      order("RANDOM()")
    end
  end
end
