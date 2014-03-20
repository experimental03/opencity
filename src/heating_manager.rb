class HeatingManager
  # Domain logic for deciding when & whether heating is to be on/off
  # If a relevant state changea, the setter triggers manage_heating to reevaluate its decision, 
  #   which is stored in @heating and passed to @heating_controller

  def initialize(heating_controller)
    @heating_controller = heating_controller  # low level controller
    @person_present = false
    @heating_requested = false
    @heating = false  # the current state
  end

  def person_present=(present)
    @person_present = present
    manage_heating
  end

  def heating_requested=(request)
    @heating_requested = request
    manage_heating
  end

  def heating?
    @heating
  end

  def manage_heating
    # TODO handle timing here
    @heating = @person_present || @heating_requested
    @heating_controller.heating = @heating  if @heating_controller
  end
end
