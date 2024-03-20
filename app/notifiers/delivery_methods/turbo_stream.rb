# app/notifiers/delivery_methods/turbo_stream.rb

class DeliveryMethods::TurboStream < ApplicationDeliveryMethod
  def deliver
    return unless recipient.is_a?(User)

    # notification.broadcast_update_to_bell
    # notification.broadcast_replace_to_index_count
    notification.broadcast_prepend_to_index_list
  end
end
