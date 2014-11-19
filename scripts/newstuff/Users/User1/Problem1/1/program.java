import java.util.Scanner;
 
class program 
{
   public static void main(String args[])
   {
      int x, y, z;
      Scanner in = new Scanner(System.in);
      x = in.nextInt();
      y = in.nextInt();
      z = Yolo.help(x) + Yolo.help(y);
      System.out.println(z);

   }
}
