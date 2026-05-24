*** Settings ***
Documentation    UI tests for the end-to-end booking flow.
Library          Browser
Library          ${EXECDIR}/libraries/data_factory.py
Resource         ../../resources/variables.robot
Resource         ../../resources/ui/browser_keywords.robot
Resource         ../../resources/ui/home_page.robot
Suite Setup      Open Browser To Base URL
Suite Teardown   Close All Browsers
Test Teardown    Take Screenshot On Failure

*** Test Cases ***
UI-004 - Deve criar uma reserva pela interface
    [Tags]    ui    regression    e2e
    ${payload}=    Generate Booking Payload    1
    Verify Rooms Are Displayed
    Click First Room Detail
    Verify Booking Form Is Visible
    Fill And Submit Booking Form
    ...    firstname=${payload}[firstname]
    ...    lastname=${payload}[lastname]
    ...    email=${payload}[email]
    ...    phone=${payload}[phone]
    ...    checkin=${payload}[bookingdates][checkin]
    ...    checkout=${payload}[bookingdates][checkout]
    Wait For Elements State    css:.bookingForm    hidden    timeout=10s
