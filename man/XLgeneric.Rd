\name{XLgeneric}
\alias{XLgeneric}
\title{Write generic rectangular data to a spreadsheet}
\usage{
XLgeneric(wb, sheet, dataset, addRownames = FALSE,
  rowNames = rownames(dataset), rowTitle = "Name", row1 = 1, col1 = 1,
  purge = FALSE)
}
\arguments{
  \item{wb}{a \code{\link[XLConnect]{workbook-class}}
  object}

  \item{sheet}{numeric or character: a worksheet name
  (character) or position (numeric) within \code{wb}.}

  \item{dataset}{the rectangular structure to be written.
  Can be a data frame, table, matrix or similar.}

  \item{addRownames}{logical: should a column of row names
  be added to the left of the structure? (default
  \code{FALSE})}

  \item{rowTitle}{character: the title to be placed above
  the row name column (default "Name")}

  \item{rowNames}{character: vector of row names. Default
  \code{rownames(dataset)}, but relevant only if
  \code{addRownames=TRUE}.}

  \item{row1,col1}{numeric: the first row and column
  occupied by the output.}

  \item{purge}{logical: should \code{sheet} be created
  anew, by first removing the previous copy if it exists?
  (default \code{FALSE})}
}
\value{
The function returns invisibly, after writing the data into
\code{sheet}.
}
\description{
Write generic data frame, matrix or table to a spreadsheet
}
\details{
This function is a convenience wrapper for getting
practically any rectangular data structure into a
spreadsheet, without worrying about conversion or
spreadsheet-writing technicalities.

If the structure is not a data frame (or inherited from
one), but a table or matrix, the function will convert it
into one using \code{\link{as.data.frame.matrix}}, because
data frames are what the exporting function
\code{\link{writeWorksheet}} can export.

The worksheet \code{sheet} does not have to pre-exist; the
function will create it if it doesn't already exist. Also,
the changes are automatically saved to file.
}
\examples{
t1<-XLwriteOpen("generic1.xls") 
XLgeneric(t1,"s1",matrix(1:4,nrow=2),row1=5,addRownames=TRUE)
XLgeneric(t1,"s1",matrix(1:4,nrow=2),col1=5,addRownames=TRUE,
          rowTitle="What?",rowNames=c("Hey","You!"))
cat("Look for",paste(getwd(),"generic1.xls",sep='/'),"to see the results!\\n")
}
\author{
Assaf P. Oron \code{<assaf.oron.at.seattlechildrens.org>}
}
\seealso{
Uses \code{\link{writeWorksheet}} to access the
spreadsheet. See \code{\link{setStyleAction}} to control
the output style. For two-way contingency tables, see
\code{\link{XLtwoWay}}.
}

