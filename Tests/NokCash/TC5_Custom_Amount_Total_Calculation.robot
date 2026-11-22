*** Settings ***
Documentation    Order summary: custom amount is carried over and total = amount + fee.
Resource         ../../Keywords/Features/Homepage_Features.robot
Resource         ../../Keywords/Features/NokCash_Features.robot
Suite Setup      Launch Browser And Open Homepage
Suite Teardown   Close Browser Session
Test Setup       Open NokCash TopUp Page From Homepage
Force Tags       nokcash    order-summary    NC-D


*** Test Cases ***
TC5 Custom Amount Total Equals Amount Plus Fee
    [Documentation]    Expected: summary amount = typed amount; total = amount + fee; no hidden charge. Does not pay.
    ${amount}=    Get Test Data    amounts    custom_amount
    Submit Amount From TopUp Page    ${amount}
    Verify Order Summary Amount    ${amount}
    Verify Order Summary Total     ${amount}
