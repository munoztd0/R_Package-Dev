Context:

I have been asked trasnform J&J Clinical & Statistical Programming standards from scripts outputting (the old way was to  create r files that the users would have to source to be able to use the functions and reproduce the desired outputs)
to an actual suite of R packages robust and versionable


Plan for presnetation
1. package development At Johnson&Johnson  Challenges, Advances and Lessons Learned Going Into Production.
1.a Challenges, - life in pharma : subtitle "tables, tables evrywhere"
   - Implement patterns used across many table shells (Developed by dedicated team but Specific to Company (unfortunately)
      - statistical methods
       - table structures
   = > Ensures all company shells can be created via core framework
1.b Advances: Shells Are Table Specific, Table Creation Is Not (Here insert graphs called img/graph1.png)
1.c Getting to Production: junco Package Features
       - True-type font support (word wrapping, pagination) + Production-ready RTF export
       - Higher order column counts + Utilities for spanning column headers
       - Guaranteed pathability in row space
       - Nearest-value (SAS-like) rounding support
       - Statistical calculations in accord with Business Logic
       - More robust approach for risk diff columns
2. From Scripts to Standardized Tools
2.a Once we had everything working we actually need to think about code design API for user !
2.b documentation -> explain roxygen2 and pkgdown birefly plus insert ifram to docs page https://johnsonandjohnson.github.io/junco/
2.c Ensuring Package Quality -> Unit testing, what is it ? brief example -> link iframe to junit test report https://johnsonandjohnson.github.io/junco/unit-test-report-non-cran/ 
    and also to this github action bot that runs unit test in PR https://github.com/johnsonandjohnson/junco/pull/53#issuecomment-3182625080
2.d all of this ads a ton of work BUT that where CI/CD comes in explain briefly and iframe to - CI/CD : https://github.com/johnsonandjohnson/junco/pull/53/checks
Ressources:

Final package name is Junco
- link to page https://johnsonandjohnson.github.io/junco/
- On Cran in version 0.1.1
- github at https://github.com/johnsonandjohnson/junco/
- logo at https://raw.githubusercontent.com/johnsonandjohnson/junco/dev/man/figures/logo.png

Web Iframes need: 
- CI/CD : https://github.com/johnsonandjohnson/junco/pull/53/checks
- junit test report https://johnsonandjohnson.github.io/junco/unit-test-report-non-cran/

::: notes
My audience can't read this but I do.
:::

Creating internal R packages helps pharmaceutical companies: * Maintain consistency across studies and therapeutic areas * Reduce time spent on repetitive coding tasks * Improve compliance with regulatory standards * Facilitate knowledge transfer between team members