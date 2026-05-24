*** Settings ***
Documentation    Page Object for the admin login panel.
Library          Browser
Resource         ../variables.robot

*** Variables ***
${ADMIN_LOGIN_URL}       ${BASE_URL}/admin
${USERNAME_FIELD}        css:#username
${PASSWORD_FIELD}        css:#password
${LOGIN_BUTTON}          css:#doLogin
${ADMIN_PANEL_HEADER}    css:.navbar-brand

*** Keywords ***
Navigate To Admin Login
    Go To    ${ADMIN_LOGIN_URL}
    Wait For Load State    networkidle

Fill Admin Login Form
    [Arguments]    ${username}    ${password}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click        ${LOGIN_BUTTON}

Verify Admin Panel Is Visible
    Wait For Elements State    ${ADMIN_PANEL_HEADER}    visible    timeout=10s

Verify Login Failed
    Wait For Elements State    ${LOGIN_BUTTON}    visible    timeout=5s
    ${count}=    Get Element Count    ${ADMIN_PANEL_HEADER}
    Should Be True    ${count} == 0    Login should have failed but admin panel is visible
