% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities.r
\name{niceRound}
\alias{niceRound}
\title{Rounding to a Predictable Number of Digits}
\usage{
niceRound(numbers, digits = 0, plurb = FALSE)
}
\arguments{
\item{numbers}{the numbers to be rounded. Can also be a vector or numeric array.}

\item{digits}{the desired number of decimal digits}

\item{plurb}{logical, should the p-value-style "less-than blurb" convention be used? Default \code{FALSE}.}
}
\description{
Rounds numbers to always have the specified number of decimal digits, rather than R's "greedy" most-compact rounding convention. Includes optional "<0.0..." override adequate for representing small p-values.
}
\details{
R's standard \code{\link{round}} utility rounds to at \emph{most} the number of digits specified. When the number happens to round more "compactly", it rounds to fewer digits. Thus, for example, \code{round(4.03,digits=2)} yields 4 as an answer. This is undesirable when trying to format a table, e.g., for publication.

\code{niceRound} solves this problem by wrapping a \code{\link{format}} call around the \code{\link{round}} call. The result will always have \code{digits} decimal digits. In addition, since reporting p-values always involves rounding, if the argument \code{plurb} is \code{TRUE}, then values below the rounding thresholds will be represented using the "less than" convention. For example, with \code{digits=3} and \code{plurb=TRUE}, the number 0.0004 will be represented as \code{<0.001}.
}
\seealso{
\code{\link{round}},\code{\link{format}}
}
\author{
Assaf P. Oron \code{<assaf.oron.at.seattlechildrens.org>}
}
