/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PracticeOlymp4;

/**
 *
 * @author user-pc
 */
public class Palindrome {
    private static long reversed(long number){
        long reversed = 0;
        long reduced;
        
        while(number > 0){
            reduced = number % 10;
            reversed = (reversed * 10) + reduced;
            number /= 10;
        }
        return reversed;
    }
    
    private static boolean isPalindrome(long number){
        return reversed(number) == number;
    }
    
    private static long largestPalindrome(long a, long b){
        long result = 0;
        long largest = 0;
        for (long x = a; x > 99; x--){
            for(long y = b; y > 99; y--){
                result = y * x;
                if(isPalindrome(result)){
                    largest = Math.max(largest, result);
                }
            }
        }
       return largest;
    }
    
    public static void main(String[] args){
        System.out.println(largestPalindrome(999, 999));
    }
}
