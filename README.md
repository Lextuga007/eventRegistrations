
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eventRegistrations

<!-- badges: start -->
<!-- badges: end -->

eventRegistrations is an R package with functions created to clean and
help filter Eventbrite registration data for healthcare events.

## Installation

You can install the development version of eventRegistrations from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("Lextuga007/eventRegistrations")
#> ℹ Loading metadata database✔ Loading metadata database ... done
#>  
#> ℹ No downloads are needed
#> ✔ 1 pkg + 25 deps: kept 26 [5.3s]
```

## Functions

`clean_company()` contains cleaning code for health and social care
organisations as were entered by people registering for the 2024 HACA
conference. The cleaning was only done for tickets related to the in
person event and not online which had a greater number of typing errors
as the field was freetext.

``` r
library(eventRegistrations)
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.5
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

# Getting sample data based on the Eventbrite export
reg_data <- sample_data()

# Clean the company column - note this is specific to health and care 
# organisations in the UK
reg_data <- clean_company(data = reg_data)
```

`filter_data()` helps to filter by various scenarios which are useful
particularly if multiple options are available on the tickets and some
are used but not all.

For Eventbrite all tickets start out as `Attending` meaning they are
registered, and if scanned in or used through a linked in online
service, become `Checked In`. The default filter for `checked_in` is to
return all tickets, to filter just by those tickets used the parameter
`checked_in = "Y"` is needed.

The 2024 HACA event was a 2 day in person and online event which also
had the option of a Networking evening and all options were available
through one registration.

``` r
# Renaming the longer readable ticket names
day_1 <- "In-person Ticket  Day 1 - 23rd July 2024"
day_2 <- "In-person Ticket Day 2 - 24th July 2024"

# Tickets from the first day that were used
filter_data(
  data = reg_data,
  tickets = day_1,
  checked_in = "Y"
) |> # this returns the email
  left_join(reg_data, join_by(email)) # join back to data for all the information
#> # A tibble: 4 × 11
#>   email    order order_date first_name last_name quantity price_tier ticket_type
#>   <chr>    <dbl> <chr>      <chr>      <chr>        <int> <lgl>      <chr>      
#> 1 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 2 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         Networking…
#> 3 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 4 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> # ℹ 3 more variables: attendee_status <chr>, company <chr>,
#> #   company_cleaned <chr>

# Tickets from the second day
filter_data(
  data = reg_data,
  tickets = day_2,
  checked_in = "Y"
) |>
  left_join(reg_data, join_by(email))
#> # A tibble: 8 × 11
#>   email    order order_date first_name last_name quantity price_tier ticket_type
#>   <chr>    <dbl> <chr>      <chr>      <chr>        <int> <lgl>      <chr>      
#> 1 ann.sm… 8.82e9 31/01/202… Ann        Smith            1 NA         In-person …
#> 2 ann.sm… 8.82e9 31/01/202… Ann        Smith            1 NA         In-person …
#> 3 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 4 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         Networking…
#> 5 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 6 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 7 fred.s… 8.83e9 11/02/202… Fred       Smith            1 NA         In-person …
#> 8 george… 8.83e9 05/02/202… George     Williams         1 NA         In-person …
#> # ℹ 3 more variables: attendee_status <chr>, company <chr>,
#> #   company_cleaned <chr>

# Tickets from both days (and return just unique people)
filter_data(
  data = reg_data,
  tickets = c(day_1, day_2),
  checked_in = "Y"
) |>
  left_join(reg_data, join_by(email))
#> # A tibble: 8 × 11
#>   email    order order_date first_name last_name quantity price_tier ticket_type
#>   <chr>    <dbl> <chr>      <chr>      <chr>        <int> <lgl>      <chr>      
#> 1 ann.sm… 8.82e9 31/01/202… Ann        Smith            1 NA         In-person …
#> 2 ann.sm… 8.82e9 31/01/202… Ann        Smith            1 NA         In-person …
#> 3 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 4 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         Networking…
#> 5 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 6 cather… 8.83e9 01/02/202… Catherine  Williams         1 NA         In-person …
#> 7 fred.s… 8.83e9 11/02/202… Fred       Smith            1 NA         In-person …
#> 8 george… 8.83e9 05/02/202… George     Williams         1 NA         In-person …
#> # ℹ 3 more variables: attendee_status <chr>, company <chr>,
#> #   company_cleaned <chr>
```

Countries can be added and this is free text and can be any country name
that is in the data:

``` r
filter_data(data = reg_data, 
            tickets = day_2, 
            country = "Wales") 
#> # A tibble: 1 × 1
#>   email             
#>   <chr>             
#> 1 fred.smith@nhs.net
```

The `add_company` parameter will return the company_cleaned column
(which is generated from the `clean_company()` function that is specific
to health and care UK organisations):

``` r
filter_data(data = reg_data, 
            tickets = day_2, 
            add_company = TRUE,
            country = "Wales") 
#> # A tibble: 1 × 2
#>   email              company_cleaned
#>   <chr>              <chr>          
#> 1 fred.smith@nhs.net Wales
```

The `mlcsu` parameter default is FALSE and will leave the data
unaffected. It is used when looking to combine multiple organisations to
be counted under MLCSU as it also includes: The Health Economics Unit,
The Strategy Unit, NHS Transformation Unit as well as MLCSU.

``` r
filter_data(data = reg_data, 
            tickets = c(day_1, day_2), 
            add_company = TRUE, 
            mlcsu = TRUE, 
            checked_in = "Y") |> 
  left_join(reg_data |> 
              select(email,
                     original_company = company))
#> Joining with `by = join_by(email)`
#> # A tibble: 8 × 3
#>   email                      company_cleaned             original_company 
#>   <chr>                      <chr>                       <chr>            
#> 1 ann.smith@nhs.net          Midlands and Lancashire CSU MLCSU            
#> 2 ann.smith@nhs.net          Midlands and Lancashire CSU MLCSU            
#> 3 catherine.williams@nhs.net NHS England                 NHS ENGLAND      
#> 4 catherine.williams@nhs.net NHS England                 NHS ENGLAND      
#> 5 catherine.williams@nhs.net NHS England                 NHS ENGLAND      
#> 6 catherine.williams@nhs.net NHS England                 NHS ENGLAND      
#> 7 fred.smith@nhs.net         Wales                       Wales            
#> 8 george.williams@nhs.net    Midlands and Lancashire CSU The Strategy Unit
```
