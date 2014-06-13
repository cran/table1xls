\name{XLgeneric}
\alias{XLgeneric}
\title{Write generic rectangular data to a spreadsheet}
\usage{
XLgeneric(wb, sheet, dataset, title = NULL, addRownames = FALSE,
  rowNames = rownames(dataset), rowTitle = "Name", colNames = NULL,
  row1 = 1, col1 = 1, purge = FALSE)
}
\arguments{
  \item{wb}{a \code{\link[XLConnect]{workbook-class}}
  object}

  \item{sheet}{numeric or character: a worksheet name
  (character) or position (numeric) within \code{wb}.}

  \item{dataset}{the rectangular structure to be written.
  Can be a data frame, table, matrix or similar.}

  \item{title}{character: an optional overall title to the
  table. Default (\code{NULL}) is no title.}

  \item{addRownames}{logical: should a column of row names
  be added to the left of the structure? (default
  \code{FALSE})}

  \item{rowTitle}{character: the title to be placed above
  the row name column (default "Name")}

  \item{rowNames}{character: vector of row names. Default
  \code{rownames(dataset)}, but relevant only if
  \code{addRownames=TRUE}.}

  \item{colNames}{character: vector of column names to
  replace the original ones. Default \code{NULL}, meaning
  that the original names are left intact. Note that the
  title for the row-names column (if
  \code{addRownames=TRUE}) is *not* considered part of
  \code{colNames}, and is set separately.}

  \item{row1,col1}{numeric: the first row and column
  occupied by the output.}

  \item{purge}{logical: should \code{sheet} be created
  anew, by first removing the previous copy if it exists?
  (default \code{FALSE})}
}
\value{
The function returns invisibly, after writing the data into
\code{sheet} and saving the file.
}
\description{
Export a generic data frame, matrix or table to a
spreadsheet and save the file.
}
\details{
This function is a convenience wrapper for getting
practically any rectangular data structure into a
spreadsheet, without worrying about conversion or
spreadsheet-writing technicalities.

If the structure is not a data frame (or inherited from
one), but a table or matrix, the function will convert it
into one using \code{\link{as.data.frame.matrix}}, because
data frames are what the underlying function
\code{\link{writeWorksheet}} can export.

See the \code{\link{XLtwoWay}} help page, for behavior
regarding new-sheet creation, overwriting, etc.
}
\examples{
t1<-XLwriteOpen("generic1.xls") 
### Just a meaningless matrix; function converts to data.frame and exports.
XLgeneric(t1,"s1",matrix(1:4,nrow=2))
### Now adding row names, title, etc. Note adding the title shifts the table one row down.
XLgeneric(t1,"s1",matrix(1:4,nrow=2),col1=5,addRownames=TRUE,
          title="Another Meaningless Table",rowTitle="What?",
          rowNames=c("Hey","You!"))

###... and now adding some text
XLaddText(t1,"s1","You can also add text here...",row1=10)
XLaddText(t1,"s1","...or here.",row1=11,col1=8)
XLaddText(t1,"s2",
          "Adding text to a new sheet name will create that sheet!"
          ,row1=2,col1=2)

### A more complicated example, showing how a "flattened" 3-way table might be exported:

carnames=paste(rep(c(4,6,8),each=2),"cylinders",rep(c("automatic","manual"),3))
XLgeneric(t1,'cars',ftable(mtcars$cyl,mtcars$vs,mtcars$am),
          addRownames=TRUE,rowNames=carnames,rowTitle="Engine Type",colNames=c("S","V"))

cat("Look for",paste(getwd(),"generic1.xls",sep='/'),"to see the results!\\n")
}
\author{
Assaf P. Oron \code{<assaf.oron.at.seattlechildrens.org>}
}
\seealso{
For two-way contingency tables, see \code{\link{XLtwoWay}}.
}

