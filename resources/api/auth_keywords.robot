*** Settings ***
Documentation    Keywords for authentication API endpoints.
Library          RequestsLibrary
Library          Collections
Resource         ../variables.robot

*** Keywords ***
Create API Session
    Create Session    booker    ${API_BASE_URL}    verify=True

Get Auth Token
    ${payload}=    Create Dictionary    username=${ADMIN_USER}    password=${ADMIN_PASS}
    ${response}=   POST On Session    booker    /auth/login    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=       Set Variable    ${response.json()}
    ${token}=      Get From Dictionary    ${body}    token
    Add Cookie To Session    booker    token    ${token}
    RETURN         ${token}

Login With Credentials
    [Arguments]    ${username}    ${password}
    ${payload}=    Create Dictionary    username=${username}    password=${password}
    ${response}=   POST On Session    booker    /auth/login    json=${payload}
    ...            expected_status=any
    RETURN         ${response}
