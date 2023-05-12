@IsTest
public class BusBookingManagerTest {

    @IsTest
    static void testGetBusDetailsWithBookingsWhen1SeatAvailableForMenOrWomen(){
        BusBookingManager.BusDetails b = new BusBookingManager.BusDetails();
        b.capacity = 5;
        b.mensBookedSeats = new List<Integer>{5};
        b.womensBookedSeats = new List<Integer> {1,2};
            
        List<BusBookingManager.Booking> bookList = new List<BusBookingManager.Booking>();
        BusBookingManager.Booking b1 = new BusBookingManager.Booking();
        b1.passengerName = 'Ishu';
        b1.gender = 'Female';
        bookList.add(b1);
        
        BusBookingManager.Booking b2 = new BusBookingManager.Booking();
        b2.passengerName = 'Gokul';
        b2.gender = 'Male';
        bookList.add(b2);
        
        Test.startTest();
        BusBookingManager.BusDetailsWithBooking busDetailWithPassangers = BusBookingManager.getBusDetailsWithBooking(b, bookList);
        Test.stopTest();
        
        Assert.areEqual(Null,busDetailWithPassangers.bookingDetails[1].seatNo);
        Assert.areEqual(3,busDetailWithPassangers.bookingDetails[0].seatNo);
        Assert.areEqual('Gokul booking Failed',busDetailWithPassangers.bookingFailedPassengers[0]);
        system.debug('busDetails'+busDetailWithPassangers);
    }
    
    @IsTest
    static void testGetBusDetailsWithBookingsWhenAllSeatsAreAvailable(){
        BusBookingManager.BusDetails b = new BusBookingManager.BusDetails();
        b.capacity = 5;
        b.mensBookedSeats = new List<Integer>{};
        b.womensBookedSeats = new List<Integer> {};
            
        List<BusBookingManager.Booking> bookList = new List<BusBookingManager.Booking>();
        BusBookingManager.Booking b1 = new BusBookingManager.Booking();
        b1.passengerName = 'Ishu';
        b1.gender = 'Female';
        bookList.add(b1);
        
        BusBookingManager.Booking b2 = new BusBookingManager.Booking();
        b2.passengerName = 'Gokul';
        b2.gender = 'Male';
        bookList.add(b2);
        
        Test.startTest();
        BusBookingManager.BusDetailsWithBooking busDetailWithPassangers = BusBookingManager.getBusDetailsWithBooking(b, bookList);
        Test.stopTest();
        
        Assert.areEqual(1,busDetailWithPassangers.bookingDetails[0].seatNo);
        Assert.areEqual(3,busDetailWithPassangers.bookingDetails[1].seatNo);
        Assert.areEqual(0,busDetailWithPassangers.bookingFailedPassengers.size());
        
        system.debug('busDetails'+busDetailWithPassangers);
    }
}