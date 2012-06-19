import java.util.*;
public class euler2 
{

	/**
	 * @param args
	 */
	

	public static void main(String[] args) 
	{
	
		int x = 0;
		int sum = 0;
		ArrayList nums = new ArrayList();
		nums.add(1);
		nums.add(2);
		System.out.println(nums);
		int c = 0;
	
		while (c < 4000000)
		{
			int a = (Integer) nums.get(x);
			int b = (Integer) nums.get(x+1);
			
			c = a + b;
			nums.add(c);
			x++;
		
		}
		
		int sum2 = 0;
		
		for (int i = 0; i < nums.size(); i++)
		{
			int current = (Integer)nums.get(i);
			
			if ( current % 2 == 0)
			{
				sum2 += current;
			}
					
		}
		System.out.println(sum2);
		
		
	}

}
