

import java.util.Arrays;

public class BuzzFizz {


	public static void main(String[] args) {
		String[] arr = new String[100];
		
		for(int i = 1; i<=arr.length;i++)//fill array 
			arr[i-1] = i+"";
		
		for(int x = 0; x<=arr.length-1;x++){
			int i = Integer.parseInt(arr[x]);
			if(i%3==0)
				arr[x] = "Buzz";
			if(i%5==0)
				arr[x] = "Fizz";
			if(i%5==0 && i%3==0)
				arr[x] = "BuzzFizz";

		}
		System.out.println(Arrays.toString(arr));
	}

}
