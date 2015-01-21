class MailsJob < ActiveJob::Base
  queue_as :send_mail

  def perform(*args)
    # Do something later
  end
end
