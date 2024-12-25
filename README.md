# Introduction

A set of utility scripts that make an effort to analysis manual pages in
FreeBSD Operating System. These utilities are developed to assist in the
identification of potential updates and modifications to manual pages.
The utilities do not make any changes to the results, it just hihglights them.

The utilities are categorized into a few main buckets:
    1. mandoc(1) - formatting style/guidance
    2. Others - Anything not a style issue, missing references.

The second category is a piece meal of trial and error to see patterns.
These patterns are based off analaysis of the outputs and subsequent tools
that are developed to be able to determine a potential course of action.

# List of mandoc(1) syntax issues checked for:
1. Lines that exceed 80 characters
2. Escape sequences that are invalid
3. Trailing blank references before .Fn
4. Missing manual title identifiers
5. Syntax error on end of sentence and no new line.
6. Tab escape sequences identified 
7. Useless macro .Tn
8. Useless macro .Ud
9. Invalid paragraph macro PP after SS 
10. Whitespaces at end of line
11. Check for no authors 

# Background on anomaly detection

The manual pages are an evolution over many decades and changes to formatting
and style. The conventions listed above are a result of this evolution.
There may be valid or invalid reasons for these entries and as such captured 
due to being identified in mandoc(1). It is important to *not* ignore these
but to determine if this is valid for the time they were created.

# Execution path for utilities
The main driver of this whole process is the: run_program.sh and should be
executed to be able to receive outoutput. 

```
    cd tools/
    sh run_program.sh
```

# Utitilies executed

Here is an inventory of the utilities and their purpose:
1. clean_up_files.sh - Will clear out previous executions of the script
2. mandoc_results.sh - Execute mandoc(1) checks
3. check_pages.sh - Wrapper to parse man(1) pages
4. parse_broken_refs.pl - Analysis and parse awk output from previous step
5. combine_outputs.pl - An attempt to consolidate outputs
6. check_whatis.pl - Execuate apropos(1) against potential issue manuals
