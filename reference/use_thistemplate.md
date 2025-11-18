# Use thistemplate theme for pkgdown

This function automatically sets up the `thistemplate` theme for your
package's pkgdown site. It will:

1.  Create or update `_pkgdown.yml` with the necessary template
    configuration

2.  Add `thistemplate` to the `Config/Needs/website` field in
    DESCRIPTION

3.  Automatically extract author and GitHub URL from `DESCRIPTION` file

## Usage

``` r
use_thistemplate()
```
