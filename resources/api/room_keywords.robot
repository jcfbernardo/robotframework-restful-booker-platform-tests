*** Settings ***
Documentation    Keywords for room API endpoints.
Library          RequestsLibrary
Library          Collections
Library          ${EXECDIR}/libraries/schema_validator.py
Library          ${EXECDIR}/libraries/data_factory.py
Resource         ../variables.robot

*** Keywords ***
Get All Rooms
    ${response}=    GET On Session    booker    /room    expected_status=any
    RETURN          ${response}

Create Room With Token
    [Arguments]     ${token}    ${payload}
    ${response}=    POST On Session    booker    /room
    ...             json=${payload}    expected_status=any
    RETURN          ${response}

Create Room Without Token
    [Arguments]     ${payload}
    ${response}=    POST On Session    booker_anon    /room
    ...             json=${payload}    expected_status=any
    RETURN          ${response}
