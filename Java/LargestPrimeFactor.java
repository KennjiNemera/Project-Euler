package PracticeOlymp4;

public class LargestPrimeFactor {
    public static void main(String[] args){
        
        long num = 600851475143L;
        long factor = 1;
        
        while (num > 1){
            factor++;
            if(primeCheck(factor) == true){
                while (num % factor == 0){
                    num /= factor;
                }
            }
        }
        System.out.println(factor);
    }
    
    public static boolean primeCheck(long x){
        for (int div = 2; div <= Math.sqrt(x); div++)
        {
            if (x % div == 0){
                return false;
            }
        }
        return true;
    }
}
