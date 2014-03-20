require 'rspec.rb'
require '../src/heating_manager.rb'

describe "heating_manager" do

  context "when person is present" do
    it "sets heating on, if heating is not requested" do
      #@heating_controller = HeatingController.new  # mock
      @heating_manager = HeatingManager.new(nil) #@heating_controller)
      #@heating_manager.heating_requested?= = false
      @heating_manager.person_present = true
      @heating_manager.heating?.should ==  true
    end

    it "sets heating on, if heating is requested" do
      #@heating_controller = HeatingController.new  # mock
      @heating_manager = HeatingManager.new(nil) #@heating_controller)
      #@heating_manager.heating_requested = true
      @heating_manager.person_present = true
      @heating_manager.heating?.should ==  true
    end
  end

end
