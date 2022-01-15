# README

[![Build Status](https://github.com/DavitTec/fileme/fileme.svg?branch=master)](https://davit.ie)


# ISSUES

* [ ] **Lines with linefeed:**   TEST file_big in the **in/**  presented lines
  with \n   or hidden character.

* |
 **Test with grep:**
      grep "^[^-;]" in/testdir

      grep "^[-;]" in/testdir

1. solution separate testdir file into two files.
  a.use in/testdocwithbreaks.txt and test file.
    Find links and lines not starting with "-" and push to new file errorfile.longest
  b. Find lines starting with "-" and send to new testdir-tmp for futher Processing
  c. If the file if too big, how about splitting and running multi process?
  d. What is the ideal size,  max file size to chunk for multi process?

2. Make sure that output file has not linebreaks and other character errors.
  a. test again for issues

* [ ] **Lines with symbolic links:**   TEST file_big in the **in/**  for links and identify if hard or soft links.  Do we remove links first.  Problem with two line wraps

* [ ] **CSV or TSV Tab serperated file.  Check **out/** for the status of testdir.CSV and look for rows not leading with "-" or "l" to find lines that wrap over two or more lines.  Caused by file names with hidden characters or New Line (\n)

* [ ] **Develop Process Map**  Must do flow charts and develop smaller routines.

* [ ] **Catch errors**  Must have error catching rountine.



## Design Goals

