package CommentStripper

import java.io.{BufferedWriter, File, FileWriter}
import scala.annotation.tailrec
import scala.io.Source._

/**
  * Tests for CommentStripper.
  *
  * @author Bennett Alex Myers
  * @version 14 September 2016
  */
object CommentStripperTest {
  def main(args: Array[String]): Unit = {

    val testInputList = read("testInputList.txt")
    val expectedOutputList = read("expectedOutputList.txt")
    val actualOutputList = {
      testInputList.map((s: String) => s.replace("in","out-actual"))
    }

      /* Strips comments and blank lines from the files on the input list */
    @tailrec
    def stripTestFiles(inputFiles: List[String],
                       outputFiles: List[String]): Unit = {
      if (inputFiles.isEmpty) Unit
      else {
        val inputFile = inputFiles.head
        val outputFile = outputFiles.head
        val strippedInput = CommentStripper.stripLines(read(inputFile))
        write(outputFile, strippedInput.mkString("\n"))
        stripTestFiles(inputFiles.tail, outputFiles.tail)
      }
    }

    /* Compares the results of the stripped files to the expected
    output files, then prints the result to the console. */
    @tailrec
    def compareOutput(expectedFiles: List[String],
                      outputFiles: List[String]): Unit = {
      if (expectedFiles.isEmpty) Unit
      else {
        val expectedFile = expectedFiles.head
        val outputFile = outputFiles.head
        print(outputFile.replace("-out-actual.txt","") + " comparison: ")
        if (expectedFile.equals("empty")) {
          println(Verifier.verifyWithText(outputFile, ""))
        }
        else println(Verifier.verifyWithFilename(outputFile,expectedFile))
        compareOutput(expectedFiles.tail, outputFiles.tail)
      }
    }

    stripTestFiles(testInputList, actualOutputList)
    compareOutput(expectedOutputList, actualOutputList)
  }

  private def read(filename: String): List[String] = {
    val source = fromFile(filename)
    val lines = source.getLines.toList
    source.close()
    lines
  }

  private def write(filename: String, text: String): Unit = {
    val writer = new BufferedWriter(new FileWriter(new File(filename)))
    writer.write(text)
    writer.close()
  }
}

/**
  * A simple verifier which compares a text file with another text file
  * or with a string.
  *
  * @author Bennett Alex Myers
  * @version 14 September 2016
  */
object Verifier {
  def verifyWithFilename(filename1: String, filename2: String): Boolean = {
    read(filename1).equals(read(filename2))
  }

  def verifyWithText(filename: String, text: String): Boolean = {
    read(filename).equals(text)
  }

  private def read(filename: String): String = {
    val source = fromFile(filename)
    val text = source.getLines.mkString("")
    source.close()
    text
  }
}
