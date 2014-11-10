import java.util.Scanner;

public class Football {

	static Scanner s = new Scanner(System.in);

	public static void main(String[] args) {
		int points = s.nextInt();
		int TD = 0;
		int S = 0;
		int F = 0;

		while (true) {
			if (points >= 9) {
				points -= 7;
				TD += 1;
			} else
				break;
			if (points >= 8) {
				points -= 6;
				TD += 1;
			} else
				break;
		}

		if (points == 8) {
			if (TD % 2 == 1) {
				TD +=1;
				S = 1;
			} else {
				F = 2;
				S = 1;
			}
		} else if (points == 7) {
			if (TD % 2 == 0) {
				TD +=1;
			} else {
				F = 1;
				S = 2;
			}
		} else if (points == 6) {
			if (TD % 2 == 1) {
				TD +=1;
			} else {
				F = 2;
				S = 0;
			}
		} else if (points == 5) {
			F = 1;
			S = 1;
		} else if (points == 4) {
			S = 2;
			F = 0;
		} else if (points == 3) {
			F = 1;
			S = 0;
		} else if (points == 2) {
			S = 1;
			F = 0;
		} else
			System.out.println(points);
		/*
		int touchdowns 	= (int)Math.floor(points/7.0);
		points = points % 7;
		int fG = 0;
		//System.out.println(points%2);
		if(points==1){
			points+=7;
			touchdowns--;
		}
		if(points%2 == 0){
			fG = (int)Math.floor(points/3);
			points = points % 3;
		}
		
		int safe = (int)Math.floor(points/2);
		points = points % 2;
		*/

		System.out.print(TD + "\n" + F + "\n" + S);
		

	}

}
