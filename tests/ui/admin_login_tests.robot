*** Settings ***
Documentation    UI tests for the admin login panel.
Library          Browser
Resource         ../../resources/variables.robot
Resource         ../../resources/ui/browser_keywords.robot
Resource         ../../resources/ui/admin_page.robot
Suite Setup      New Browser    browser=${BROWSER}    headless=${HEADLESS}
Suite Teardown   Close All Browsers
Test Setup       Run Keywords    New Context    AND    Navigate To Admin Login
Test Teardown    Run Keywords    Take Screenshot On Failure    AND    Close Context

*** Test Cases ***
UI-005 - Deve acessar tela de login admin
    [Tags]    ui    smoke    admin
    Wait For Elements State    ${USERNAME_FIELD}    visible    timeout=10s

UI-006 - Deve logar no admin com credenciais válidas
    [Tags]    ui    smoke    admin
    Fill Admin Login Form    ${ADMIN_USER}    ${ADMIN_PASS}
    Verify Admin Panel Is Visible

UI-007 - Não deve logar com credenciais inválidas
    [Tags]    ui    negative    admin
    Fill Admin Login Form    wrong_user    wrong_pass
    Verify Login Failed
