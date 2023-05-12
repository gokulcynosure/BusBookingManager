public class BusBookingManager {
    
    public static SeatsAvailable  seatsForMenAndWomen;
    
    public static BusDetailsWithBooking getBusDetailsWithBooking(BusDetails bc,List<Booking> bookings){
        List<Integer> availableSeats = new List<Integer>();
        List<Integer> womensOccupiedSeats = bc.womensBookedSeats;
        List<Integer> mensOccupiedSeats = bc.mensBookedSeats;
        List<String> bookingFailedPassengers = new List<String>();
        
        for(Integer i = 1; i <= bc.capacity; i++){
            if(!womensOccupiedSeats.contains(i) && !mensOccupiedSeats.contains(i)){
                availableSeats.add(i);
            }
        }
        BusBookingManager.seatsForMenAndWomen  = getMensAndWomensAvailableSeats(availableSeats,mensOccupiedSeats,womensOccupiedSeats);
        for(Booking b : bookings){
            if(b.gender == 'Female'){
                if(BusBookingManager.seatsForMenAndWomen.womensAvailableSeats.size() != 0){
                    b.seatNo = BusBookingManager.seatsForMenAndWomen.womensAvailableSeats[0];
                    BusBookingManager.seatsForMenAndWomen.womensAvailableSeats.remove(0);
                    Integer indexForNextSeat = BusBookingManager.seatsForMenAndWomen.mensAvailableSeats.indexOf(b.seatNo + 1);
                    Integer indexForPreviousSeat = BusBookingManager.seatsForMenAndWomen.mensAvailableSeats.indexOf(b.seatNo -1);
                    if(indexForNextSeat != -1){
                        BusBookingManager.seatsForMenAndWomen.mensAvailableSeats.remove(indexForNextSeat);
                    }
                    if(indexForPreviousSeat != -1){
                        BusBookingManager.seatsForMenAndWomen.mensAvailableSeats.remove(indexForPreviousSeat);
                    }
                    womensOccupiedSeats.add(b.seatNo);
                    Integer indexForcurrentSeat = availableSeats.indexOf(b.seatNo);
                    availableSeats.remove(indexForcurrentSeat);
                    BusBookingManager.seatsForMenAndWomen = getMensAndWomensAvailableSeats(availableSeats,mensOccupiedSeats,womensOccupiedSeats);
                    
                }else{
                    bookingFailedPassengers.add(b.passengerName +' ' + 'booking Failed');
                }
            }else{
                if(b.gender == 'Male'){
                    if(BusBookingManager.seatsForMenAndWomen.mensAvailableSeats.size() != 0){
                        b.seatNo = BusBookingManager.seatsForMenAndWomen.mensAvailableSeats[0];
                        BusBookingManager.seatsForMenAndWomen.mensAvailableSeats.remove(0);
                        Integer indexOfNextSeat = BusBookingManager.seatsForMenAndWomen.womensAvailableSeats.indexOf(b.seatNo + 1);
                        Integer indexOfPreviousSeat = BusBookingManager.seatsForMenAndWomen.womensAvailableSeats.indexOf(b.seatNo - 1);
                        if(indexOfNextSeat != -1){
                            BusBookingManager.seatsForMenAndWomen.womensAvailableSeats.remove(indexOfNextSeat);
                        }
                        if(indexOfPreviousSeat != -1){
                            BusBookingManager.seatsForMenAndWomen.womensAvailableSeats.remove(indexOfPreviousSeat);
                        }
                        mensOccupiedSeats.add(b.seatNo);
                        Integer indexForcurrentSeat = availableSeats.indexOf(b.seatNo);
                        availableSeats.remove(indexForcurrentSeat);
                        BusBookingManager.seatsForMenAndWomen = getMensAndWomensAvailableSeats(availableSeats,mensOccupiedSeats,womensOccupiedSeats);
                    }else{
                        bookingFailedPassengers.add(b.passengerName +' ' + 'booking Failed');
                    }
                }
            }
        }
        
        BusDetailsWithBooking busDetailWithBooking = new BusDetailsWithBooking();
        BusDetails bus = new BusDetails();
        bus.capacity = bc.capacity;
        bus.mensBookedSeats = mensOccupiedSeats;
        bus.womensBookedSeats = womensOccupiedSeats;
        busDetailWithBooking.busDetails = bus;
        busDetailWithBooking.bookingDetails = bookings;
        busDetailWithBooking.bookingFailedPassengers = bookingFailedPassengers;
        
        return busDetailWithBooking;
    }
    
    private static SeatsAvailable getMensAndWomensAvailableSeats(List<Integer> availableSeats,List<Integer> mensOccupiedSeats,list<Integer> womensOccupiedSeats){
       	List<Integer> unAvailableSeatsForWomens = new List<Integer>();
        List<Integer> unAvailableSeatsForMens = new List<Integer>();
        List<Integer> availableSeatMens = new List<Integer>();
        List<Integer> availableSeatWomens = new List<Integer>();
        
       for(Integer menSeat : mensOccupiedSeats){
            unAvailableSeatsForWomens.add(availableSeats.contains(menSeat - 1) ? menSeat - 1 :null);
            unAvailableSeatsForWomens.add(availableSeats.contains(menSeat + 1) ? menSeat + 1 :null);
        }
        
        for(Integer womenSeat : womensOccupiedSeats){
            unAvailableSeatsForMens.add(availableSeats.contains(womenSeat - 1) ? womenSeat - 1 :null);
            unAvailableSeatsForMens.add(availableSeats.contains(womenSeat + 1) ? womenSeat + 1 :null);
        }
        
        for(Integer i : availableSeats ){
            if(!unAvailableSeatsForMens.contains(i)){
                availableSeatMens.add(i);
            }
            if(!unAvailableSeatsForWomens.contains(i)){
                availableSeatWomens.add(i);
            }
        }
        SeatsAvailable seatsAvail = new SeatsAvailable();
        seatsAvail.mensAvailableSeats = availableSeatMens;
        seatsAvail.womensAvailableSeats = availableSeatWomens;
        return seatsAvail;                                        
     }
    public Class BusDetails {
        public Integer capacity{get;set;}
        public List<Integer> womensBookedSeats{get;set;}
        public List<Integer> mensBookedSeats{get;set;}
    }
   	public Class Booking {
        public string passengerName{get;set;}
        public string gender{get;set;}
        public integer seatNo{get;set;}
    }
    
    public Class BusDetailsWithBooking{
        public BusDetails busDetails{get;set;}
        public List<Booking> bookingDetails{get;set;}
        Public List<String> bookingFailedPassengers{get;set;}
    }
    
    public Class SeatsAvailable{
        public List<integer> mensAvailableSeats{get;set;}
        public List<integer> womensAvailableSeats{get;set;}
        
    }
}
