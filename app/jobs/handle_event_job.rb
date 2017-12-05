##
# This class defines the HandleEventJob which delegets the passed event
# to the event handler in the goodbot module.
# This job will be executed by sidekiq and queued in the default queue.

class HandleEventJob < ApplicationJob
  queue_as :default

  ##
  # Performs the job by passing the +event+ to the event handler.

  def perform(event)
    Goodbot::Handler::Event.new(event).handle
  end
end
