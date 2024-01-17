require "rails_helper"

RSpec.describe Airline, type: :model do
  describe "relationships" do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  it 'returns distinct adult passengers' do
    airline = Airline.create(name: 'Example Airline')

    adult_passenger1 = Passenger.create(name: 'Adult Passenger 1', age: 25)
    adult_passenger2 = Passenger.create(name: 'Adult Passenger 2', age: 30)
    child_passenger = Passenger.create(name: 'Child Passenger', age: 10)

    flight1 = Flight.create(number: 'FL123', date: '2024-01-20', airline: airline)
    flight2 = Flight.create(number: 'FL456', date: '2024-01-21', airline: airline)

    flight1.passengers << [adult_passenger1, child_passenger]
    flight2.passengers << [adult_passenger2, child_passenger]

    result = airline.adult_passengers

    expect(result).to contain_exactly(adult_passenger1, adult_passenger2)
  end
end
