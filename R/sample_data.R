#' Sample data based on Eventbrite exports
#'
#' @return tribble
#' @export
#'
sample_data <- function() {
  tibble::tribble(
    ~Order, ~Order.Date, ~First.Name, ~Last.Name, ~Email, ~Quantity, ~Price.Tier, ~Ticket.Type, ~Attendee.Status, ~Company,
    8821786949, "31/01/2024 19:30", "Ann", "Smith", "ann.smith@nhs.net", 1L, NA, "In-person Ticket  Day 1 - 23rd July 2024", "Attending", "MLCSU",
    8821786949, "31/01/2024 19:30", "Ann", "Smith", "ann.smith@nhs.net", 1L, NA, "In-person Ticket Day 2 - 24th July 2024", "Checked In", "MLCSU",
    8828401379, "01/02/2024 16:01", "Bert", "Brown", "bert.brown@nhs.net", 1L, NA, "In-person Ticket  Day 1 - 23rd July 2024", "Attending", "NHS E",
    8828401379, "01/02/2024 16:01", "Bert", "Brown", "bert.brown@nhs.net", 1L, NA, "In-person Ticket Day 2 - 24th July 2024", "Attending", "NHS E",
    8828401379, "01/02/2024 16:01", "Bert", "Brown", "bert.brown@nhs.net", 1L, NA, "Networking Event", "Checked In", "NHS E",
    8828404619, "01/02/2024 16:01", "Catherine", "Williams", "catherine.williams@nhs.net", 1L, NA, "In-person Ticket  Day 1 - 23rd July 2024", "Checked In", "NHS ENGLAND",
    8828404619, "01/02/2024 16:01", "Catherine", "Williams", "catherine.williams@nhs.net", 1L, NA, "Networking Event", "Checked In", "NHS ENGLAND",
    8828404619, "01/02/2024 16:01", "Catherine", "Williams", "catherine.williams@nhs.net", 1L, NA, "In-person Ticket Day 2 - 24th July 2024", "Checked In", "NHS ENGLAND",
    8828504600, "01/02/2024 17:21", "Catherine", "Williams", "catherine.williams@nhs.net", 1L, NA, "In-person Ticket Day 2 - 24th July 2024", "Checked In", "NHS ENGLAND",
    8828504600, "11/02/2024 17:21", "Fred", "Smith", "fred.smith@nhs.net", 1L, NA, "In-person Ticket Day 2 - 24th July 2024", "Checked In", "Wales",
    8826500000, "05/02/2024 10:18", "George", "Williams", "george.williams@nhs.net", 1L, NA, "In-person Ticket Day 2 - 24th July 2024", "Checked In", "The Strategy Unit"
    )
}
