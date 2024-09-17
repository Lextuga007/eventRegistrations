#' Function to filter Eventbrite data
#'
#' @param data extracted from Eventbrite
#' @param tickets String Categories are "In-person Ticket  Day 1 - 23rd July
#' 2024", "In-person Ticket Day 2 - 24th July 2024", "Online Ticket" and
#' "Networking Event".
#' @param remove_dups Logical Default is to remove duplicates from emails or
#' from emails and company_cleaned if used in conjunction with the `add_company`
#' parameter
#' @param checked_in String Default is to include both `Attending` and
#' `Checked In` or can be defined with `"Both"`. "Y" returns just the tickets
#' that are `Checked In` and "N" returns just `Attending`.
#' @param country String Default is NA and is used in conjunction with
#' \code{\link{clean_company}} where the country name is added to the cleaned
#' company: "Northern Ireland", "Scotland", and "Wales".
#' @param mlcsu String Default is FALSE. When set to TRUE the company_cleaned
#' categories for all departments in MLCSU are recoded to "Midlands and
#' Lancashire CSU". Includes Health Economics Unit, The Strategy Unit and MLCSU.
#' @param add_company String Default is FALSE. When TRUE includes the
#' company_cleaned column in the output data file and is used only where
#' company_cleaned is needed as there are duplicates as some tickets have the
#' same email but different organisations.
#'
#' @return Dataframe
#' @export
#'
#' @examples
filter_data <- function(data,
                        tickets,
                        remove_dups = TRUE,
                        checked_in = c("Both", "Y", "N"),
                        country = NA,
                        mlcsu = FALSE,
                        add_company = FALSE) {
  df <- clean_company(data = data)

  checked_in <- match.arg(checked_in)

  if (!is.na(country)) {
    df <- df |>
      dplyr::filter(stringr::str_detect(company_cleaned, country))
  }

  if (checked_in == "Both") {
    df <- df |>
      dplyr::filter(ticket_type %in% c(tickets))
  }

  if (checked_in == "Y") {
    df <- df |>
      dplyr::filter(
        ticket_type %in% c(tickets),
        attendee_status == "Checked In"
      )
  }

  if (checked_in == "N") {
    df <- df |>
      dplyr::filter(
        ticket_type %in% c(tickets),
        attendee_status == "Attending"
      )
  }

  if (remove_dups == TRUE & add_company == FALSE) {
    df <- df |>
      dplyr::distinct(email)
  }

  if (remove_dups == TRUE & add_company == TRUE) {
    df <- df |>
      dplyr::distinct(
        email,
        company_cleaned
      )
  }

  if (mlcsu == TRUE) {
    df <- df |>
      dplyr::mutate(company_cleaned = dplyr::case_when(
        company_cleaned %in% c(
          "Midlands and Lancashire CSU",
          "The Strategy Unit",
          "Health Economics Unit",
          "NHS Transformation Unit"
        ) ~ "Midlands and Lancashire CSU",
        .default = company_cleaned
      ))
  }

  df
}
