

import java.util.Scanner;

public class NameReverse {
static Scanner scn = new Scanner(System.in);

	public static void main(String []args){
		String input= scn.nextLine();
		input = input.replaceAll("a", "");	
		input = input.replaceAll("A", "");

		
		System.out.println(input);
		
	}
	
	
}
