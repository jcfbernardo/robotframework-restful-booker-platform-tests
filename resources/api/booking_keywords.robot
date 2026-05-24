*** Settings ***
Documentation    Keywords for booking API endpoints.
Library          RequestsLibrary
Library          Collections
Library          ${EXECDIR}/libraries/schema_validator.py
Library          ${EXECDIR}/libraries/data_factory.py
Resource         ../variables.robot

*** Keywords ***
Create Booking
    [Arguments]     ${payload}
    ${headers}=     Create Dictionary    Content-Type=application/json    Accept=application/json
    ${response}=    POST On Session    booker    /booking/
    ...             json=${payload}    headers=${headers}    expected_status=any
    RETURN        ${response}

Get Booking By Id
    [Arguments]     ${booking_id}    ${token}=${EMPTY}
    ${cookies}=     Create Dictionary    token=${token}
    ${response}=    GET On Session    booker    /booking/${booking_id}    cookies=${cookies}    expected_status=any
    RETURN        ${response}
