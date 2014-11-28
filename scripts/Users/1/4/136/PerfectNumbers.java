

import java.util.Arrays;

public class PerfectNumbers {

	public static void main(String[] args) {
		int start = 2;
		int i = start, x = 0;
		int [] arr = new int[4];
		while(true){
			if(isPrime(i++))
				arr[x++] = (int)(Math.pow(2,i-2)*(Math.pow(2,i-1)-1));
			if(arr[3] != 0)break;
		}
		System.out.print(arr[0]);

		for(int ix = 1; ix < arr.length; ix++)
		System.out.print(", " + arr[ix]);
	}
	
	static boolean isPrime(int x){
		for(int n=x-1; n>1; n--)
			if(x%n==0)
				return false;
		return true;
	}

}
