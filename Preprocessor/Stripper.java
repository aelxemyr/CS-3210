import java.lang.Character;

/**
 * Write a description of class Parser here.
 * 
 * @author Bennett Alex Myers
 * @version 26 August 2016
 */
public class Stripper
{
    private Status status;
    private String currentLine;
    private char[] currentLineArray;
    private String outLine;
    
    /**
     * Constructor for objects of class Parser
     */
    public Stripper()
    {
        this.status = Status.BLANK;
        this.currentLine = "";
        this.currentLineArray = null;
        this.outLine = "";
    }
    
    public String strip(String input) {
        setCurrentLine(input);
        processLine();
        return this.outLine;
    }
    
    public Status getStatus() {
        return this.status;
    }
    
    public void setCurrentLine(String line) {
        this.currentLine = line;
        this.currentLineArray = currentLine.toCharArray();
    }
    
    public String getOutLine() {
        return this.outLine;
    }
    
    public void resetOutLine() {
        this.outLine = "";
    }
    
    public void processLine() {
        char current;
        char next;
        boolean isBlankLine = true;
        resetOutLine();
        for (int i = 0; i < currentLineArray.length; i++) {
            current = currentLineArray[i];
            if ( i + 1 != currentLineArray.length ) {
                next = currentLineArray[i + 1];
            }
            else {
                next = ' ';
            }
            if (status != Status.BLANK) {
                isBlankLine = false;
            }
            switch (status) {
                case BLANK:
                    i = blankCase(current, next, i);
                    break;
                case CODE:
                    i = codeCase(current, next, i);
                    break;
                case STRING:
                    i = stringCase(current, next, i);
                    break;
                case CHAR:
                    i = charCase(current, next, i);
                    break;
                case END_COMMENT:
                    if (i == 0) {
                        this.status = Status.BLANK;
                        outLine += current;
                    }
                    break;
                case BLOCK_COMMENT:
                    i = blockCommentCase(current, next, i);
                    break;
            }
        }
        if (isBlankLine) {
            resetOutLine();
        }
        if (status == Status.CODE) {
            this.status = Status.BLANK;
        }
    }
    
    private int blankCase(char current, char next, int index) {
        if (current == '\"') {
            this.status = Status.STRING;
            outLine += current;
            return index;
        }
        else if (current == '\'') {
            this.status = Status.CHAR;
            outLine += current;
            return index;
        }
        else if (current == '/' && next == '/') {
            this.status = Status.END_COMMENT;
            resetOutLine();
            return index + 1;
        }
        else if (current == '/' && next == '*') {
            this.status = Status.BLOCK_COMMENT;
            resetOutLine();
            return index + 1;
        }
        else if (Character.isWhitespace(current)) {
            outLine += current;
            return index;
        }
        else {
            this.status = Status.CODE;
            outLine += current;
            return index;
        }
    }
    
    private int codeCase(char current, char next, int index) {
        if (current == '\"') {
            this.status = Status.STRING;
            outLine += current;
            return index;
        }
        else if (current == '\'') {
            this.status = Status.CHAR;
            outLine += current;
            return index;
        }
        else if (current == '/' && next == '/') {
            this.status = Status.END_COMMENT;
            return index + 1;
        }
        else if (current == '/' && next == '*') {
            this.status = Status.BLOCK_COMMENT;
            return index + 1;
        }
        else {
            outLine += current;
            return index;
        }
    }
    
    private int stringCase(char current, char next, int index) {
        if (current == '\\') {
            outLine = outLine + current + next;
            return index + 1;
        }
        else if (current == '\"') {
            this.status = Status.CODE;
            outLine += current;
            return index;
        }
        else {
            outLine += current;
            return index;
        }
    }
    
    private int charCase(char current, char next, int index) {
        if (current == '\\') {
            outLine = outLine + current + next;
            return index + 1;
        }
        else if (current == '\'') {
            this.status = Status.CODE;
            outLine += current;
            return index;
        }
        else {
            this.status = Status.CODE;
            outLine = outLine + current + next;
            return index + 1;
        }
    }
    
    private int endCommentCase(char current, int index) {
        if (index == 0) {
            this.status = Status.BLANK;
            outLine += current;
        }
        return index;
    }
    
    private int blockCommentCase(char current, char next, int index) {
        if (current == '*' && next == '/') {
            this.status = Status.BLANK;
            return index + 1;
        }
        else {
            return index;
        }
    }
}