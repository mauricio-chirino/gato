class ProcessPaymentJob < ApplicationJob

  queue_as :default

  def perform
    sleep 3
    puts "payment is processed"

    Turbo::StreamsChannel.broadcast_replace_to(
      "payments",
      target: "post-details",
      template: "post/show",
      layout: false  
    )

  end

end

 