% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DBDriver.R
\name{dbConnect}
\alias{dbConnect}
\title{Create a connection to a DBMS}
\usage{
dbConnect(drv, ...)
}
\arguments{
\item{drv}{an object that inherits from \code{\linkS4class{DBIDriver}},
or an existing \code{\linkS4class{DBIConnection}}
object (in order to clone an existing connection).}

\item{...}{authorization arguments needed by the DBMS instance; these
typically include \code{user}, \code{password}, \code{dbname}, \code{host},
\code{port}, etc.  For details see the appropriate \code{DBIDriver}.}
}
\value{
An object that extends \code{\linkS4class{DBIConnection}} in a
database-specific manner. For instance \code{dbConnect(RMySQL::MySQL())} produces
an object of class \code{MySQLConnection}. This object is used to direct
commands to the database engine.
}
\description{
Connect to a DBMS going through the appropriate authorization procedure.
Some implementations may allow you to have multiple connections open, so you
may invoke this function repeatedly assigning its output to different
objects. The authorization mechanism is left unspecified, so check the
documentation of individual drivers for details.
}
\details{
Each driver will define what other arguments are required, e.g.,
\code{"dbname"} for the database name, \code{"username"}, and
\code{"password"}.
}
\section{Specification}{


DBI specifies only the return type for \code{dbConnect()}.

}

\examples{
# SQLite only needs a path to the database. Other database drivers
# will require more details (like username, password, host, port etc)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
con

dbListTables(con)

dbDisconnect(con)
}
\seealso{
\code{\link[=dbDisconnect]{dbDisconnect()}} to disconnect from a database.

Other DBIDriver generics: \code{\link{DBIDriver-class}},
  \code{\link{dbDataType}}, \code{\link{dbDriver}},
  \code{\link{dbGetInfo}}, \code{\link{dbIsValid}},
  \code{\link{dbListConnections}}
}
