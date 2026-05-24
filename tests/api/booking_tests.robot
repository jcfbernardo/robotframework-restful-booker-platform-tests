*** Settings ***
Documentation     BOOKING test suite: create, get, invalid dates, missing fields.
Library           RequestsLibrary
Library           Collections
Library           ${EXECDIR}/libraries/schema_validator.py
Library           ${EXECDIR}/libraries/data_factory.py
Resource          ../../resources/variables.robot
Resource          ../../resources/api/auth_keywords.robot
Resource          ../../resources/api/booking_keywords.robot
Suite Setup       Run Keywords
...               Create API Session    AND
...               Acquire First Available Room Id

*** Variables ***
${ROOM_ID}              1
${CREATED_BOOKING_ID}   ${EMPTY}

*** Keywords ***
Acquire First Available Room Id
    ${response}=    GET On Session    booker    /room/    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${rooms}=       Get From Dictionary    ${response.json()}    rooms
    ${first_room}=  Get From List    ${rooms}    0
    ${rid}=         Get From Dictionary    ${first_room}    roomid
    Set Suite Variable    ${ROOM_ID}    ${rid}

*** Test Cases ***
BOOKING-001 - Deve criar booking com dados válidos
    [Tags]    booking    smoke
    ${payload}=    Generate Booking Payload    ${ROOM_ID}
    ${response}=   Create Booking    ${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    ${body}=       Set Variable    ${response.json()}
    Validate Booking Response Schema    ${body}
    Set Suite Variable    ${CREATED_BOOKING_ID}    ${body}[bookingid]

BOOKING-002 - Deve consultar booking criado
    [Tags]    booking    regression
    ${response}=    Get Booking By Id    ${CREATED_BOOKING_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=        Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    firstname

BOOKING-003 - Não deve criar booking com datas inválidas
    [Tags]    booking    negative
    ${bad_dates}=     Generate Invalid Booking Dates
    ${payload}=       Generate Booking Payload    ${ROOM_ID}
    Set To Dictionary    ${payload}    bookingdates=${bad_dates}
    ${response}=      Create Booking    ${payload}
    Should Not Be Equal As Integers    ${response.status_code}    201

BOOKING-004 - Não deve criar booking sem dados obrigatórios
    [Tags]    booking    negative
    ${payload}=    Create Dictionary    roomid=${ROOM_ID}
    ${response}=   Create Booking    ${payload}
    Should Not Be Equal As Integers    ${response.status_code}    201
