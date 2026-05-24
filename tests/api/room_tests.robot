*** Settings ***
Documentation     ROOM test suite: list rooms, create with/without token, invalid payload.
Library           RequestsLibrary
Library           Collections
Library           ${EXECDIR}/libraries/schema_validator.py
Library           ${EXECDIR}/libraries/data_factory.py
Resource          ../../resources/variables.robot
Resource          ../../resources/api/auth_keywords.robot
Resource          ../../resources/api/room_keywords.robot
Suite Setup       Run Keywords
...               Create API Session    AND
...               Authenticate And Store Token

*** Keywords ***
Authenticate And Store Token
    ${token}=    Get Auth Token
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

*** Test Cases ***
ROOM-001 - Deve listar rooms disponíveis
    [Tags]    room    smoke
    ${response}=    Get All Rooms
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=        Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    rooms
    Validate Room List Response Schema    ${body}

ROOM-002 - Deve criar room com token válido
    [Tags]    room    regression
    ${payload}=    Generate Room Payload
    ${response}=   Create Room With Token    ${AUTH_TOKEN}    ${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    ${body}=       Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    roomid

ROOM-003 - Não deve criar room sem token
    [Tags]    room    negative
    ${payload}=    Generate Room Payload
    ${response}=   Create Room Without Token    ${payload}
    Should Be Equal As Integers    ${response.status_code}    403

ROOM-004 - Não deve criar room com payload inválido
    [Tags]    room    negative
    ${payload}=    Create Dictionary    roomName=${EMPTY}
    ${response}=   Create Room With Token    ${AUTH_TOKEN}    ${payload}
    Should Not Be Equal As Integers    ${response.status_code}    201
