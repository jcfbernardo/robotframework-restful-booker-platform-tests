*** Settings ***
Documentation    Common browser setup/teardown keywords using Robot Framework Browser library.
Library          Browser
Resource         ../variables.robot

*** Keywords ***
Open Browser To Base URL
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context
    New Page       ${BASE_URL}
    Wait For Load State    networkidle

Close All Browsers
    Close Browser    ALL

Take Screenshot On Failure
    Run Keyword If Test Failed    Take Screenshot    fullPage=True
