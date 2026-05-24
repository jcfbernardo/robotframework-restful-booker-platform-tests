*** Settings ***
Documentation    UI tests for the end-to-end booking flow.
Library          Browser
Resource         ../../resources/variables.robot
Resource         ../../resources/ui/browser_keywords.robot
Resource         ../../resources/ui/home_page.robot
Suite Setup      Open Browser To Base URL
Suite Teardown   Close All Browsers
Test Teardown    Take Screenshot On Failure

*** Test Cases ***
UI-004 - Deve criar uma reserva pela interface
    [Tags]    ui    regression    e2e
    Verify Rooms Are Displayed
    Click First Room Detail
    Verify Booking Form Is Visible
    Wait For Elements State    ${RESERVE_BUTTON}    visible    timeout=10s
