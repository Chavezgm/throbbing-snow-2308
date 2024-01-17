require 'rails_helper'
RSpec.describe "airlines passangers" do 

  it 'returns a list of unique adult passengers' do
    airline = Airline.create(name: 'Example Airline')
  
    adult_passenger1 = Passenger.create(name: 'Adult Passenger 1', age: 25)
    adult_passenger2 = Passenger.create(name: 'Adult Passenger 2', age: 30)
    child_passenger = Passenger.create(name: 'Child Passenger', age: 10)
  
    flight1 = Flight.create(number: 'FL123', date: '2024-01-20', airline: airline)
    flight2 = Flight.create(number: 'FL456', date: '2024-01-21', airline: airline)
  
    flight1.passengers << [adult_passenger1, child_passenger]
    flight2.passengers << [adult_passenger2, child_passenger]
  
    unique_adult_passengers = airline.adult_passengers
  
    expect(unique_adult_passengers).to include(adult_passenger1)
    expect(unique_adult_passengers).to include(adult_passenger2)
    expect(unique_adult_passengers).not_to include(child_passenger)
  end
  
end