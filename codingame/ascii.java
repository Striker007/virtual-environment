import java.util.*;

class Solution {
    
    public static void main(String args[]) {
        Scanner in = new Scanner(System.in);
        int letterWidth = in.nextInt();
        int letterHeight = in.nextInt();
        if (in.hasNextLine()) {
            in.nextLine();
        }
        char[] lineOfText = in.nextLine().toUpperCase().toCharArray();

        while(in.hasNextLine()) {
            String asciiRow = in.nextLine();
            int unknownCharPosition = asciiRow.length() - letterWidth;
            int charPosition;

            for (char c: lineOfText) {
                if ((int)c >= 'A' && (int)c <= 'Z') {
                    charPosition = letterWidth * (c - 'A');         
                } else {
                    charPosition = unknownCharPosition;
                }
                System.out.print(asciiRow.substring(charPosition, charPosition + letterWidth));
            }
            System.out.println("");
        }
    }  
}
