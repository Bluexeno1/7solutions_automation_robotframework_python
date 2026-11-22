*** Settings ***
Documentation    Equivalence partition: empty amount must be rejected.
Resource         ../../Keywords/Features/Homepage_Features.robot
Resource         ../../Keywords/Features/NokCash_Features.robot
Suite Setup      Launch Browser And Open Homepage
Suite Teardown   Close Browser Session
Test Setup       Open NokCash TopUp Page From Homepage
Force Tags       nokcash    negative    NC-EP


*** Test Cases ***
TC3 Empty Amount Is Rejected
    [Documentation]    Expected: required-field message, no navigation to the payment page.
    Verify Amount Is Rejected    ${EMPTY}
