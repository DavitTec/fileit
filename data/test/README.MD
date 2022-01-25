# README
[![Maintenance](https://img.shields.io/badge/Build&nbsp;Status-in&nbsp;progress-red?style=plastic)](https://github.com/DavitTec/fileit/pulse)
![version](https://img.shields.io/badge/version-0.5.1-red?style=plastic)


**:wrench: WARNING** Work in progress, there needs a few changes and fixes in the TEST Folder.


# ISSUES

* [ ] **Lines with linefeed:**   TEST file_big in the **in/**  presented lines
  with \n   or hidden character.

* |
 **Test with grep:**
 
      grep "^[^-;]" in/testdir

      grep "^[-;]" in/testdir

* [ ]
  a. Find links and lines not starting with "-" and push to new log file.
  b. Find lines starting with "-" and send to new file for futher processing
  c. If the file is too big, how about splitting and running multi processess?
  d. What is the ideal size,  max file size to chunk for multi process?

* [ ] Make sure that output file has no linebreaks and other character errors.
  a. test again for issues

* [ ] **Lines with symbolic links:**   TEST file_big in the **in/**  for links and identify if hard or soft links.  Do we remove links first.  Problem with two line wraps

* [ ] **CSV or TSV Tab serperated file.  Check **out/** for the status of testdir.CSV and look for rows not leading with "-" or "l" to find lines that wrap over two or more lines.  Caused by file names with hidden characters or New Line (\n)

* [ ] **Develop Process Map**  Must do flow charts and develop smaller routines.

* [ ] **Catch errors**  Must have error catching rountine.


## Design Goals
* Error tolerant design - ....
* Fast and lightweight
  * Memory-efficient data structures
* Rules based
  * Adheres to
* Simple and maintainable over time
  * Testable
* Written in

## Get Started
---

## TODO
| VERSION        | ITEM                               | Description                                    |
| --------------:|:----------------------------------:|:-----------------------------------------------|
|            0.5 | **directorylist.sh**               | did a few changes to the structure             |
|            0.4 |                                    |                                                |
|            0.3 |                                    |                                                |

TODO  file array loop DISABLED

* [ ] NEED OPTIMIZING FOR SPEED when using sed. Execution speed needs to be increased (due to large input files or slow processors or hard disks).
   -  This could be achieved using "find" expression is specified before giving the "s/.../.../". eg
   
          sed -i '/old text/ s//new text/g' gigantic_file.csv
        
* [ ] replace any hard coding of input filenames and paths

* [ ] NEED to establish a more efficient populate database

* [ ] NEED to include Time estimate and a Progress bar
     this process may that >hours depending on input file size

* [ ] NEED Catch errors and Quit options

* [ ] NEED to present OPTIONS and USAGE


