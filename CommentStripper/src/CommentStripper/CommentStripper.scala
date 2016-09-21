package CommentStripper

import scala.annotation.tailrec

/**
  * A preprocessor for a program. Strips blank lines and comments
  * from a text file.
  *
  * @author Bennett Alex Myers
  * @version 14 September 2016
  */
object CommentStripper {

  /**
    * First removes comments, then removes blank lines from the lines of a
    * text file, given as a list of strings
    *
    * @param lines The lines of the text file.
    * @return The lines of the text, stripped of comments and blank lines.
    */
  def stripLines(lines: List[String]): List[String] = {
    removeBlankLines(removeComments(lines))
  }

  /**
    * Removes lines consisting only of whitespace from a text file, given
    * as a list of strings.
    *
    * @param lines The lines of a text file as a list of strings
    * @return The original list with blank lines removed
    */
  def removeBlankLines(lines: List[String]): List[String] = {
    lines.filter(line => line.trim != "")
  }

  /**
    * Remove line comments and block comments from a text file, given as a
    * list of strings. The function will ignore comment delimiters in
    * character and string literals.
    *
    * @param lines The lines of a text file as a list of strings
    * @return The original list with comments removed
    */
  def removeComments(lines: List[String]): List[String] = {

    /* All inner functions represent a distinct state for processing text.
    Each function recursively processes a list of characters representing
    the text, and add characters to an accumulator as appropriate. If the
    end of the file is reached, the accumulator is returned, regardless of
    state. */

    // Default text state: all non-special symbols added to accumulator
    @tailrec
    def matchText(text: List[Char], acc: String): String = text match {
      case Nil => acc
      case '\'' :: tail => matchCharLiteral(tail, acc + '\'')
      case '\"' :: tail => matchStringLiteral(tail, acc + '\"')
      case '/' :: '/' :: tail => matchLineComment(tail, acc)
      case '/' :: '*' :: tail => matchBlockComment(tail, acc + '\n')
      case head :: tail => matchText(tail, acc + head)
    }

    // Char literal state: all text added to accumulator until delimiter
    @tailrec
    def matchCharLiteral(text: List[Char],
                         acc: String): String = text match {
      case Nil => acc
      case '\\' :: '\'' :: tail => matchCharLiteral(tail, acc + "\\'")
      case '\'' :: tail => matchText(tail, acc + '\'')
      case head :: tail => matchCharLiteral(tail, acc + head)
    }

    // String literal state: all text added to accumulator until delimiter
    @tailrec
    def matchStringLiteral(text: List[Char],
                           acc: String): String = text match {
      case Nil => acc
      case '\\' :: '\"' :: tail => matchStringLiteral(tail, acc + "\\\"")
      case '\"' :: tail => matchText(tail, acc + '\"')
      case head :: tail => matchStringLiteral(tail, acc + head)
    }

    // Line comment state: no text added until end of line
    @tailrec
    def matchLineComment(text: List[Char],
                         acc: String): String = text match {
      case Nil => acc
      case '\n' :: tail => matchText(tail, acc + '\n')
      case head :: tail => matchLineComment(tail, acc)
    }

    // Block comment state: no text added until delimiter
    @tailrec
    def matchBlockComment(text: List[Char],
                          acc: String): String = text match {
      case Nil => acc
      case '*' :: '/' :: tail => matchText(tail, acc)
      case head :: tail => matchBlockComment(tail, acc)
    }

    // Initial call: process lines from text as a list of characters.
    matchText(lines.mkString("\n").toList,"").split("\n").toList
  }
}