*** Settings ***
Documentation    UI tests for the public home page.
Library          Browser
Resource         ../../resources/variables.robot
Resource         ../../resources/ui/browser_keywords.robot
Resource         ../../resources/ui/home_page.robot
Suite Setup      Open Browser To Base URL
Suite Teardown   Close All Browsers
Test Teardown    Take Screenshot On Failure

*** Test Cases ***
UI-001 - Deve carregar a home pública
    [Tags]    ui    smoke
    Verify Home Page Is Loaded

UI-002 - Deve exibir rooms disponíveis
    [Tags]    ui    smoke
    Verify Rooms Are Displayed

UI-003 - Deve abrir detalhes de um room
    [Tags]    ui    regression
    Verify Rooms Are Displayed
    Click First Room Detail
    Verify Booking Form Is Visible
