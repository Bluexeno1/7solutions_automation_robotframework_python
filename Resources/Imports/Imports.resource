*** Settings ***
Documentation    Single place for every library import. Keyword files import only this file.
Library          SeleniumLibrary    timeout=15s    run_on_failure=Capture Page Screenshot
Library          Collections
Library          String
Library          ${EXECDIR}/Resources/Python_handler/config_handler.py
Library          ${EXECDIR}/Resources/Python_handler/locator_handler.py
Library          ${EXECDIR}/Resources/Python_handler/amount_helper.py
