import java.util.Scanner;



public class ParkingLot {
	 static Scanner s = new Scanner(System.in);

	public static void main(String[] args) {
		//have 10 minutes
		double[] speeds   = new double[4];//array for different speeds
		double[] distance = new double[4];//array for different distances
		double[] fixTime  = {1, 2.5, 5, 0};//array for different fix times
		String[] types    = {"bike","scooter","car","running"}; //define types of transport array
		
		//input and make all mph
		for(int i=0; i<4; i++)speeds[i] = s.nextDouble();//get diffrernt speeds and put them into an array
		speeds[3] = speeds[3]*60*60/5280;//ft/sec*sec/min*hr/min*mi/ft=mi/hr
		
		for(int i=0; i<4; i++){
			distance[i]//distance = 
					=(10-fixTime[i])//time you have to move
					/60 //in hours
					* speeds[i] ;//times speed
			
		}
		
		
		int maximumInd=0;
		//print speeds
		for(int i=0; i<4; i++){
			System.out.printf("%1$.2f", distance[i]);
			System.out.println();
			if(distance[maximumInd]<distance[i])
				maximumInd=i;
		}
		
		System.out.println(types[maximumInd]);
		s.close();
		
	}

}
