class RelicDecorator < Draper::Decorator
  delegate_all

  def desc_wrapper
    'Data discovered on this device: [' + object.device_output + '] '
  end

end
