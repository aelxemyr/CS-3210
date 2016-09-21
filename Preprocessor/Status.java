
/**
 * Possible states for stripping text file of blank lines and comments.
 * 
 * @author Bennett Alex Myers
 * @version 29 August 2016
 */
public enum Status
{
    BLANK, CODE, STRING, CHAR, END_COMMENT, BLOCK_COMMENT
}
