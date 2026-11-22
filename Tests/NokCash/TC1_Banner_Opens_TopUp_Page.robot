*** Settings ***
Documentation    NC-01: Clicking the NokCash banner on the homepage opens the top-up page.
Resource         ../../Keywords/Features/Homepage_Features.robot
Suite Setup      Launch Browser And Open Homepage
Suite Teardown   Close Browser Session
Force Tags       nokcash    smoke    NC-01


*** Test Cases ***
TC1 Click NokCash Banner Opens Top-Up Page
    [Documentation]    Expected: top-up page loads with the amount field; no error or 404.
    Open NokCash TopUp Page From Homepage
    ${title}=    Get Title
    Should Not Contain    ${title}    404
    Page Should Not Contain    Page Not Found
