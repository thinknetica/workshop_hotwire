class ApplicationCommand < TurboBoost::Commands::Command
  class StreamsProxy
    def initialize(command, stream_builder)
      @command, @stream_builder = command, stream_builder
    end

    def respond_to_missing?(mid, ...) = @stream_builder.respond_to?(mid, ...)

    def method_missing(mid, ...)
      return super unless @stream_builder.respond_to?(mid)

      @command.turbo_streams << @stream_builder.public_send(mid, ...)
    end
  end

  delegate(
    :current_user,
    :flash,
    :request,
    to: :controller
  )

  private

  def redirect_to(url)
    streams << turbo_stream.invoke("Turbo.visit", args: [url], camelize: false)
  end

  def turbo_stream
    @turbo_stream ||= StreamsProxy.new(self, super)
  end
end
