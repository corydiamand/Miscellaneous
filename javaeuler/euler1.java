
public class euler1 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		System.out.println("Hello World!");
		
		int x = 0;
		int sum = 0;
		
		while (x < 1000)
		{
			if (x % 5 == 0 || x % 3 == 0)
			{
				sum += x;
			}
			
			x++;
		}
		
		System.out.println(sum);

	};

}
