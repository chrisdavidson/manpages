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
    8. Whitespaces at end of line

# Background on anomaly detection
The manual pages are an evolution over many decades and changes to formatting
and style. The conventions listed above are a result of this evolution.
There may be valid or invalid reasons for these entries and as such captured 
due to being identified in mandoc(1). It is important to *not* ignore these
but to determine if this is valid for the time they were created.

