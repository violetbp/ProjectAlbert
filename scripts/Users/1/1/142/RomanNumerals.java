

import java.util.HashMap;
import java.util.Scanner;

public class RomanNumerals {

static Scanner scn = new Scanner(System.in);

static HashMap<Character,Integer> vals = new HashMap<Character,Integer>();
{
	vals.put('I',1);
	vals.put('V',5);
	vals.put('X',10);
	vals.put('L',50);
	vals.put('C',100);
	vals.put('D',500);
	vals.put('M',1000);
}

	public int comp(char i, char s){
		return vals.get(i).compareTo(vals.get(s));
	}
	
	
	public static void main(String[] args) {
		String input = scn.nextLine();
		Character[] arr = new Character[input.length()];
		int total = 0;
		for(int i = 0; i<input.length()-1; i++)
			arr[i] = input.charAt(i);
			
		for(int i = 0; i<arr.length-1; i++){
			try{
				switch(arr[i]){
				case 'I': total +=1;
					break;
				case 'V': total +=5;
					break;
				case 'X': total +=10;
					break;
				case 'L': total +=50;
					break;
				case 'C': total +=100;
					break;
				case 'D': total +=500;
					break;
				case 'M': total +=1000;
					break;
				}
				
				
			}catch(ArrayIndexOutOfBoundsException e){e.getMessage();}
		}
		
	

		
	}

}
