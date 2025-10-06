#' @title Use thistemplate theme for pkgdown
#'
#' @description
#' This function automatically sets up the `thistemplate` theme for your package's pkgdown site.
#' It will:
#' 1. Create or update `_pkgdown.yml` with the necessary template configuration
#' 2. Add `thistemplate` to the `Config/Needs/website` field in DESCRIPTION
#' 3. Automatically extract author and GitHub URL from `DESCRIPTION` file
#'
#' @md
#' @export
use_thistemplate <- function() {
  root_pkgdown <- "_pkgdown.yml"
  if (file.exists(root_pkgdown)) {
    pkgdown_path <- root_pkgdown
  } else {
    pkgdown_files <- list.files(
      path = ".",
      pattern = "_pkgdown\\.yml$",
      recursive = TRUE,
      full.names = TRUE
    )

    if (length(pkgdown_files) == 0) {
      pkgdown_path <- root_pkgdown
    } else {
      inst_pkgdown <- pkgdown_files[grepl("inst/pkgdown", pkgdown_files)]
      if (length(inst_pkgdown) > 0) {
        pkgdown_path <- inst_pkgdown[1]
      } else {
        pkgdown_path <- pkgdown_files[1]
        cli::cli_alert_warning(
          "No {.file _pkgdown.yml} found in {.path root} or {.path inst/pkgdown}"
        )
      }
    }
  }

  author_info <- desc::desc_get_author()
  author <- gsub("^([^<]+).*$", "\\1", author_info)
  author <- trimws(author)

  github_url <- desc::desc_get_urls()
  if (length(github_url) > 0) {
    github_url <- github_url[grepl("github", github_url)]
    if (length(github_url) > 0) {
      github_url <- github_url[1]
    }
  } else {
    cli::cli_alert_warning(
      "No GitHub URL found in {.file DESCRIPTION}"
    )
    github_url <- NULL
  }

  if (!file.exists(pkgdown_path)) {
    yaml_content <- list(
      template = list(
        bootstrap = 5,
        `light-switch` = TRUE,
        package = "thistemplate"
      )
    )

    yaml_content$navbar <- list(
      structure = list(
        left = c("articles", "reference", "tutorials", "news"),
        right = c("github", author, "lightswitch")
      ),
      components = list(
        github = list(
          icon = "fab fa-github fa-lg",
          href = github_url,
          "aria-label" = "GitHub"
        )
      )
    )

    yaml::write_yaml(yaml_content, pkgdown_path)
    cli::cli_alert_success(
      "Created {.file _pkgdown.yml} with {.pkg thistemplate} configuration"
    )
  } else {
    yaml_content <- yaml::read_yaml(pkgdown_path)

    if (is.null(yaml_content$template)) {
      yaml_content$template <- list()
    }
    if (is.null(yaml_content$template$package)) {
      yaml_content$template$package <- "thistemplate"
    }
    if (is.null(yaml_content$template$`light-switch`)) {
      yaml_content$template$`light-switch` <- TRUE
    }
    if (is.null(yaml_content$template$bootstrap)) {
      yaml_content$template$bootstrap <- 5
    }

    if (!is.null(yaml_content$navbar) && !is.null(yaml_content$navbar$structure)) {
      right <- yaml_content$navbar$structure$right
      if (is.null(right)) {
        right <- character()
      }
      if (!"lightswitch" %in% right) {
        yaml_content$navbar$structure$right <- c(right, "lightswitch")
      }
    }

    yaml_content$navbar$components$github <- list(
      icon = "fab fa-github fa-lg",
      href = github_url,
      "aria-label" = "GitHub"
    )

    yaml::write_yaml(yaml_content, pkgdown_path)
    cli::cli_alert_success(
      "Updated {.file {pkgdown_path}} with {.pkg thistemplate} configuration"
    )
  }

  desc <- desc::description$new("DESCRIPTION")
  desc$set("Config/Needs/website", "mengxu98/thistemplate")
  desc$write()
  cli::cli_alert_success(
    "Updated {.file DESCRIPTION} with {.pkg thistemplate} dependency"
  )

  invisible(TRUE)
}
