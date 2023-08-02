module Cache
  module_function

  def store
    @cache ||= Litecache.new
  end
end