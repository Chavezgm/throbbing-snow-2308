require 'rails_helper'

RSpec.describe 'Flights Index Page', type: :feature do
  it 'Visitor sees a list of flight numbers with airline names and passenger names' do

    airline = Airline.create( name: 'Example Airline')
    flight = Flight.create(number: 'FL123', date: '2024-01-20', airline: airline, departure_city: 'City A', arrival_city: 'City B')
    passenger1 = Passenger.create( name: 'Passenger 1', age: 25)
    passenger2 = Passenger.create( name: 'Passenger 2', age: 30)

    flight.passengers << [passenger1, passenger2]

    visit flights_path

    expect(page).to have_content("Flight Number")
    expect(page).to have_content("Airline")
    expect(page).to have_content("Passengers")

    expect(page).to have_content(flight.number)
    expect(page).to have_content(airline.name)

    expect(page).to have_content(passenger1.name)
    expect(page).to have_content(passenger2.name)
  end

  it 'Visitor removes a passenger from a flight' do
  
    airline = Airline.create(name: 'Example Airline')

    flight1 = Flight.create(number: 'FL123', date: '2024-01-20', airline: airline, departure_city: 'City A', arrival_city: 'City B')
    flight2 = Flight.create(number: 'DLE78', date: '2024-01-20', airline: airline, departure_city: 'City c', arrival_city: 'City D')

    passenger1 = Passenger.create(name: 'Passenger 1', age: 25)
    passenger2 = Passenger.create(name: 'Passenger 2', age: 30)

    flight1.passengers << [passenger1, passenger2]
    flight2.passengers << passenger1

    visit flights_path

    within "#flight_#{flight1.id}" do
      expect(page).to have_content(passenger1.name)
      expect(page).to have_content(passenger2.name)
      within "#passenger_#{passenger1.id}" do
        click_link 'Remove'
      end 
    end

    within "#flight_#{flight1.id}" do
      expect(page).not_to have_content(passenger1.name)
      expect(page).to have_content(passenger2.name)
    end

    within "#flight_#{flight2.id}" do
      expect(page).to have_content(passenger1.name)
    end 

    within "#flight_#{flight1.id}" do
    expect(page).to have_content(passenger2.name)
    end
  end
end 