*** Settings ***
Documentation     AUTH test suite: health check, valid login, invalid login.
Library           RequestsLibrary
Library           Collections
Resource          ../../resources/variables.robot
Resource          ../../resources/api/auth_keywords.robot
Suite Setup       Create API Session

*** Test Cases ***
AUTH-001 - Deve retornar health check da API de autenticação
    [Tags]    auth    smoke
    ${payload}=    Create Dictionary    token=healthcheck
    ${response}=   POST On Session    booker    /auth/validate    json=${payload}    expected_status=any
    Should Be True    ${response.status_code} in [200, 403, 401]

AUTH-002 - Deve realizar login com credenciais válidas
    [Tags]    auth    smoke
    ${response}=    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASS}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=        Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    token
    Should Not Be Empty    ${body}[token]

AUTH-003 - Não deve realizar login com credenciais inválidas
    [Tags]    auth    negative
    ${response}=    Login With Credentials    invalid_user    wrong_pass
    Should Not Be Equal As Integers    ${response.status_code}    200
    ${body}=        Set Variable    ${response.json()}
    Dictionary Should Not Contain Key    ${body}    token
