*** Settings ***
Documentation    Boundary value: minimum - 1 must be rejected (scenario "Custom amount = minimum - 1").
Resource         ../../Keywords/Features/Homepage_Features.robot
Resource         ../../Keywords/Features/NokCash_Features.robot
Suite Setup      Launch Browser And Open Homepage
Suite Teardown   Close Browser Session
Test Setup       Open NokCash TopUp Page From Homepage
Force Tags       nokcash    negative    boundary    NC-BVA


*** Test Cases ***
TC2 Amount Below Minimum Is Rejected
    [Documentation]    Expected: error message shown, user stays on the top-up page.
    ${min}=       Get Test Data    amount_rules    min_amount
    ${amount}=    Boundary Amount    ${min}    -1
    Verify Amount Is Rejected    ${amount}
