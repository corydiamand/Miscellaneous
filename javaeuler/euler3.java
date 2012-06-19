import java.math.BigInteger;


public class euler3 
{

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		BigInteger x = new BigInteger("0");
		BigInteger y = new BigInteger("600851475143");
		BigInteger z = new BigInteger("1");
	
		while (x.compareTo(y) == -1) 
		{
			
			
			x = x.add(z);
		}

		System.out.println("EYY");
	}

}
