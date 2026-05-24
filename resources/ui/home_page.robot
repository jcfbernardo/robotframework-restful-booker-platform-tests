*** Settings ***
Documentation    Page Object for the public home page.
Library          Browser
Resource         ../variables.robot

*** Variables ***
${ROOM_CARD_LOCATOR}      a[href^="/reservation/"]
${BOOKING_HEADING}        h2:has-text("Book This Room")
${RESERVE_BUTTON}         button:has-text("Reserve Now")

*** Keywords ***
Verify Home Page Is Loaded
    Get Title    ==    Restful-booker-platform demo

Verify Rooms Are Displayed
    Wait For Elements State    ${ROOM_CARD_LOCATOR} >> nth=0    visible    timeout=15s
    ${count}=    Get Element Count    ${ROOM_CARD_LOCATOR}
    Should Be True    ${count} > 0

Click First Room Detail
    Click    ${ROOM_CARD_LOCATOR} >> nth=0

Verify Booking Form Is Visible
    Wait For Elements State    ${BOOKING_HEADING}    visible    timeout=15s
