*** Settings ***
Documentation    Page Object for the public home page.
Library          Browser
Resource         ../variables.robot

*** Variables ***
${ROOM_CARD_LOCATOR}      css:.hotel-room-info
${ROOM_DETAIL_LOCATOR}    css:.openBooking
${BOOKING_FORM}           css:.hotel-room-book
${BOOKING_BUTTON}         css:.btn-outline-primary

*** Keywords ***
Verify Home Page Is Loaded
    Get Title    ==    Restful Booker Platform

Verify Rooms Are Displayed
    Wait For Elements State    ${ROOM_CARD_LOCATOR}    visible    timeout=15s
    ${count}=    Get Element Count    ${ROOM_CARD_LOCATOR}
    Should Be True    ${count} > 0

Click First Room Detail
    Wait For Elements State    ${ROOM_DETAIL_LOCATOR}    visible    timeout=15s
    Click    ${ROOM_DETAIL_LOCATOR} >> nth=0

Verify Booking Form Is Visible
    Wait For Elements State    ${BOOKING_FORM}    visible    timeout=10s

Fill And Submit Booking Form
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${phone}
    ...            ${checkin}    ${checkout}
    Fill Text    css:[name="firstname"]    ${firstname}
    Fill Text    css:[name="lastname"]     ${lastname}
    Fill Text    css:[name="email"]        ${email}
    Fill Text    css:[name="phone"]        ${phone}
    Fill Text    css:[name="checkin"]      ${checkin}
    Fill Text    css:[name="checkout"]     ${checkout}
    Click        ${BOOKING_BUTTON}
