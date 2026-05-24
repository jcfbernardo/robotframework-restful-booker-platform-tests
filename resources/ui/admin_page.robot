*** Settings ***
Documentation    Page Object for the admin login panel.
Library          Browser
Resource         ../variables.robot

*** Variables ***
${ADMIN_LOGIN_URL}       ${BASE_URL}/admin
${USERNAME_FIELD}        [placeholder="Enter username"]
${PASSWORD_FIELD}        [type="password"]
${LOGIN_BUTTON}          button:has-text("Login")
${LOGOUT_BUTTON}         button:has-text("Logout")

*** Keywords ***
Navigate To Admin Login
    New Page    ${ADMIN_LOGIN_URL}
    Wait For Load State    networkidle

Fill Admin Login Form
    [Arguments]    ${username}    ${password}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click        ${LOGIN_BUTTON}

Verify Admin Panel Is Visible
    Wait For Elements State    ${LOGOUT_BUTTON}    visible    timeout=10s

Verify Login Failed
    ${url}=    Get Url
    Should Contain      ${url}    /admin
    Should Not Contain  ${url}    /rooms
