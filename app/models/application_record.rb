# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def random
      order('RANDOM()')
    end
  end
end
