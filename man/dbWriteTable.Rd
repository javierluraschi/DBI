% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DBConnection.R
\name{dbWriteTable}
\alias{dbWriteTable}
\title{Copy data frames to database tables}
\usage{
dbWriteTable(conn, name, value, ...)
}
\arguments{
\item{conn}{A \code{\linkS4class{DBIConnection}} object, as returned by
\code{\link[=dbConnect]{dbConnect()}}.}

\item{name}{A character string specifying a DBMS table name.}

\item{value}{a \link{data.frame} (or coercible to data.frame).}

\item{...}{Other parameters passed on to methods.}
}
\value{
\code{dbWriteTable()} returns \code{TRUE}, invisibly.
If the table exists (and both \code{append} and \code{overwrite} arguments are unset),
an error is raised; the remote table remains unchanged.

An error is also raised
if \code{name} cannot be processed with \code{\link[=dbQuoteIdentifier]{dbQuoteIdentifier()}}
or if this results in a non-scalar.
Invalid values for the additional arguments \code{row.names},
\code{overwrite}, \code{append}, \code{field.types}, and \code{temporary}
(non-scalars,
unsupported data types,
\code{NA},
incompatible values)
also raise an error.
}
\description{
Writes, overwrites or appends a data frame to a database table, optionally
converting row names to a column and specifying SQL data types for fields.
}
\section{Additional arguments}{


The following arguments are not part of the \code{dbWriteTable()} generic
(to improve compatibility across backends)
but are part of the DBI specification:
\itemize{
\item \code{row.names} (default: \code{NA})
\item \code{overwrite} (default: \code{FALSE})
\item \code{append} (default: \code{FALSE})
\item \code{field.types} (default: \code{NULL})
\item \code{temporary} (default: \code{FALSE})
}

They must be provided as named arguments.
See the "Specification" and "Value" sections for details on their usage.

}

\section{Specification}{


The \code{name} argument is processed as follows,
to support databases that allow non-syntactic names for their objects:
\itemize{
\item If an unquoted table name as string: \code{dbWriteTable()} will do the quoting,
perhaps by calling \code{dbQuoteIdentifier(conn, x = name, ...)}
so that all optional arguments are passed along
\item If the result of a call to \code{\link[=dbQuoteIdentifier]{dbQuoteIdentifier()}}: no more quoting is done
}

If the \code{overwrite} argument is \code{TRUE}, an existing table of the same name
will be overwritten.
This argument doesn't change behavior if the table does not exist yet.

If the \code{append} argument is \code{TRUE}, the rows in an existing table are
preserved, and the new data are appended.
If the table doesn't exist yet, it is created.

If the \code{temporary} argument is \code{TRUE}, the table is not available in a
second connection and is gone after reconnecting.
Not all backends support this argument.
A regular, non-temporary table is visible in a second connection
and after reconnecting to the database.

SQL keywords can be used freely in table names, column names, and data.
Quotes, commas, and spaces can also be used in the data,
and, if the database supports non-syntactic identifiers,
also for table names and column names.

The following data types must be supported at least,
and be read identically with \code{\link[=dbReadTable]{dbReadTable()}}:
\itemize{
\item integer
\item numeric
(also with \code{Inf} and \code{NaN} values,
the latter are translated to \code{NA})
\item logical
\item \code{NA} as NULL
\item 64-bit values (using \code{"bigint"} as field type)
\item character (in both UTF-8
and native encodings)
\item factor (returned as character)
\item list of raw
(if supported by the database)
\item date
(if supported by the database;
returned as integers with class \code{Date})
\item time
(if supported by the database;
returned as objects that inherit from \code{difftime})
\item timestamp
(if supported by the database;
with time zone support)
}

The interpretation of \link{rownames} depends on the \code{row.names} argument,
see \code{\link[DBI:sqlRownamesToColumn]{DBI::sqlRownamesToColumn()}} for details:
\itemize{
\item If \code{FALSE}, row names are ignored.
\item If \code{TRUE}, row names are converted to a column named "row_names",
even if the input data frame only has natural row names from 1 to \code{nrow(...)}.
\item If \code{NA}, a column named "row_names" is created if the data has custom row names,
no extra column is created in the case of natural row names.
\item If a string, this specifies the name of the column in the remote table
that contains the row names,
even if the input data frame only has natural row names.
}

}

\examples{
con <- dbConnect(RSQLite::SQLite(), ":memory:")

dbWriteTable(con, "mtcars", mtcars[1:5, ])
dbReadTable(con, "mtcars")

dbWriteTable(con, "mtcars", mtcars[6:10, ], append = TRUE)
dbReadTable(con, "mtcars")

dbWriteTable(con, "mtcars", mtcars[1:10, ], overwrite = TRUE)
dbReadTable(con, "mtcars")

# No row names
dbWriteTable(con, "mtcars", mtcars[1:10, ], overwrite = TRUE, row.names = FALSE)
dbReadTable(con, "mtcars")

}
\seealso{
Other DBIConnection generics: \code{\link{DBIConnection-class}},
  \code{\link{dbDataType}}, \code{\link{dbDisconnect}},
  \code{\link{dbExecute}}, \code{\link{dbExistsTable}},
  \code{\link{dbGetException}}, \code{\link{dbGetInfo}},
  \code{\link{dbGetQuery}}, \code{\link{dbIsValid}},
  \code{\link{dbListFields}}, \code{\link{dbListResults}},
  \code{\link{dbListTables}}, \code{\link{dbReadTable}},
  \code{\link{dbRemoveTable}}, \code{\link{dbSendQuery}},
  \code{\link{dbSendStatement}}
}
