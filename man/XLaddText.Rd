\name{XLaddText}
\alias{XLaddText}
\title{Write text to a single cell}
\usage{
XLaddText(wb, sheet, text, row1 = 1, col1 = 1)
}
\arguments{
  \item{wb}{a \code{\link[XLConnect]{workbook-class}}
  object}

  \item{sheet}{numeric or character: a worksheet name
  (character) or position (numeric) within \code{wb}.}

  \item{text}{character: the text to be written to file.}

  \item{row1,col1}{integer: the row and column for the
  output.}
}
\value{
The function returns invisibly, after writing the data into
\code{sheet} and saving the file.
}
\description{
Write text to a single cell in a specified file and sheet,
and save the file.
}
\details{
Since XLConnect only exports data to spreadsheets as
`data.frame`, this function sends the text as an on-the-fly
`data.frame` with one column and one row, and without
writing the header or the row name.
}
\note{
If the specified \code{sheet} does not exist, the function
will create it, assuming that was the user's intent (e.g.,
add a text-only sheet with explanations to a file.) This is
hard-coded, because the inadvertent creation of single-text
sheets due to typos can be easily discovered upon opening
the file :)
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

