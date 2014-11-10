import java.util.Scanner;



public class CharlieBrown {
 static Scanner s = new Scanner(System.in);

	public static void main(String[] args) {
	int stairs  = s.nextInt();
	double pumpkins=0;
	for(int x = 1; x<=stairs; x++) pumpkins += x;
	 
	pumpkins*=2;//batteries needed
	System.out.println(((int)Math.ceil(pumpkins/3)));
	}
}