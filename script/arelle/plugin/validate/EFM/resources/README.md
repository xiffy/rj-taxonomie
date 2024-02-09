# Resources files maintenance

The resources directory includes files which are maintained by release or as needed.

### edgartaxonomies

This directory contains edgarwarning files for specific SEC releases as well as for all-years operation of
EDGAR EFM validation.  They are provided by SEC staff to specify acceptable common taxonomy and linkbases
for a specific release (for the current and prior historical releases).

When a new edgartaxonomy file is produced, or additional taxonomies added to an existing file, the file
EdgarRenderer/resources/TaxonomyAddonManager.xml is also updated by SEC staff to add any new corresponding 
label documentation and references linkbases for EdgarRenderer to be aware of.

### axiswarnings.json, signwarnings.json

These files are used for axis and sign warnings except for US-GAAP filings after 2020, where they are replaced 
by DQCRT rules implementing the same functionality.  This file is hand-maintained by SEC staff.

### *-deprecated-concepts.json

Invest-deprecated-concepts.json is provided for historical purposes (all concepts are deprecated).

All the other -deprecated-concepts.json files (except invest-) are regenerated by SEC staff for each release as follows:

* Check latestTaxonomyDocs in parent directory file Consts.py, there must be an entry for each maintained deprecated file specifying an array of deprecatedLabels file URLs, labelRole and datePattern.  The deprecatedLabels files array is updated
every time there's another release of the corresponding taxonomy.  SEC staff update this array as needed.

* List the files which are expected to be regenerated, e.g. `ls *-deprecated-concepts.json` to compare to later.

* Delete all the -deprecated-concepts.json files **except invest-deprecated-concepts.json** (which can't be regenerated), e.g., `rm [cdenrsuv]*deprecated-concepts.json ifrs-full-deprecated-concepts.json`

* With arelle selection `efm-pragmatic-all-years` run test suite 622-only-supported-locations/622-01-all-supported-locations with disclosure system validation checked.  There'll be messages such as "[info] loading dei/* deprecated concepts..." as it rebuilds the deprecated files.

* The list of files from `ls *-deprecated-concepts.json` should match the list produced before regenerating (no deprecation file not generated).

* Rerun the deprecated files test cases 605-instance-syntax/605-42-deprecated

### dei-validations.json

This file contains validation rules for dei, cover page and header tag facts and is maintained by SEC staff.

### dqc-us-rules.json

This file contains rule parameters used by Filing.py to process DQCRT rules for supported years and is maintained by SEC staff.

Note that DQCRT rules filtering is available by use of the dqcRuleFilter parameter which can be specified by command line or 
GUI Formula Parameters dialog.  (See __init__.py comment documentation in the parent (EFM) directory.)

### us-gaap-rels-YYYY.json

These files are generated from DQCRT and us-gaap common taxonomy files for each DQCRT release.  They are manually re-generated by SEC staff by deleting the file and running a test instance for the corresponding year's taxonomy, against the special DQCRT disclosure system testing mode.

### taxonomy-compatibility.json

This file is maintained by SEC staff on each release introducing a new common taxonomy to specify which other common taxonomy releases it is intended to be compatible with.
