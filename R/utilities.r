##'
##'
##' Open a spreadsheet document, while deleting the previous copy.
##'
##' 
##' Open a spreadsheet file (.xls or .xlsx), while deleting the previous copy if it exists.
##' 
##' The XLConnect function \code{\link{loadWorkbook}} can open existing spreadsheets or create new ones if they don't exist. 
##' However, it *cannot* delete the previous copy when opening the new one -- which is the default behavior of software such as R. 
##' As a result, analysts might inadvertently mix old and new versions of data and results, in the same spreadsheet.
##' 
##' This short utility mitigates this risk, by calling \code{\link{unlink}} first to make sure existing copies are deleted before the new spreadsheet file is opened.
##' 
##' @note Even though the workbook object is created, and is linked to a specific file name, it will only be saved to disk after \code{\link{saveWorkbook}} is called. See example. The example also illustrates some of the peculiarities of working with \code{\link{XLConnect}}, many of which are taken care of when using \code{table1xls} functions.
##' 
##' @param path character: the spreadsheet's full filename, including the extension. Only \code{.xls, .xlsx} extensions are allowed.
##' 
##' @return an XLConnect workbook object.
##' @example inst/examples/ExOpen.r
##' 
##' @author Assaf P. Oron \code{<assaf.oron.at.seattlechildrens.org>}
##' 
##' @seealso \code{\link{loadWorkbook}}, \code{\link{saveWorkbook}}

XLwriteOpen<-function(path)
{
unlink(path)
loadWorkbook(path,create=TRUE)
}

##' Utility functions for table summaries
##' 
##' 
##' Various auxiliary convenience functions, mostly for \code{\link{XLunivariate}}.

##' Functions calculating simple statistics and returning the output in a formatted manner, making it easier for \code{\link{XLunivariate}} to embed them in spreadsheet cells.
##' 
##' This is a small collection of useful utilities called by \code{\link{XLunivariate}}. They return 1-2 summary statistics, in a format that will not require additional formatting and formula-manipulation in Excel.
##' 
##' For example, \code{\link{roundmedian}} returns the median rounded to the specified number of digits, while \code{\link{iqrString}} returns the 1st and 3rd quartiles, separated by at least one dash (default 3 dashes). \code{\link{XLunivariate}} can combine these functions' output to produce the formatted summary \code{"median (Q1---Q3)"} often used in research articles.
##' 
##' In particular, \code{emptee} returns an empty string, enabling the use of  \code{\link{XLunivariate}} to produce only a single summary statistic per cell rather than a pair.
##' 
##' @example inst/examples/ExUnivar.r 
##'  
##' @param x vector (usually numeric, but can be logical) on which statistics are to be calculated
##' @param digits numeric: how many digits to round the output to?
##' @param quantmeth numeric: for functions calling \code{\link{quantile}}, the calculation method for the quantiles. Default is 7 to match the R default. Note that it is shrunk towards the median and hence biased, but typically with lower MSE. A very viable alternative is 6, the SAS/SPSS (and Stata?) default, which is unbiased. See the help on \code{\link{quantile}} for more details.
##' @param na.rm logical: should missing values be removed? (default \code{FALSE}) Passed onto the underlying functions
##' @param sep character: separating character for range- type functions.
##' @param ... this is ignored by the functions, but enables the "mixing and matching" of extra parameters between functions called by \code{\link{XLunivariate}}, without triggering an error.
##' 
##' @return The summary statistic(s), in the format specified via the arguments.
##' 
##' @seealso \code{\link{XLunivariate}} which is the main function calling these utilities.
##' 
##' @author Assaf P. Oron \code{<assaf.oron.at.seattlechildrens.org>}
##' 
rangeString<-function(x,digits=1,sep='-',na.rm=FALSE,...) paste(round(min(x,na.rm=na.rm),digits),'-',round(max(x,na.rm=na.rm),digits),sep=sep)

##' @rdname rangeString

iqrString<-function(x,digits=1,sep='-',quantmeth=7,na.rm=FALSE,...) 
{
  tmp<-quantile(x,type=quantmeth,na.rm=na.rm,prob=c(1/4,3/4))
  paste(round(tmp[1],digits),'-',round(tmp[2],digits),sep=sep)
}

##' @rdname rangeString

roundmean<-function(x,digits=1,na.rm=FALSE,...) round(mean(x,na.rm=na.rm),digits=digits)

##' @rdname rangeString

roundmedian<-function(x,digits=1,na.rm=FALSE,...) round(median(x,na.rm=na.rm),digits=digits)

##' @rdname rangeString

roundSD<-function(x,digits=1,na.rm=FALSE,...) round(sd(x,na.rm=na.rm),digits=digits)

##' @rdname rangeString

emptee<-function(x,...) ""