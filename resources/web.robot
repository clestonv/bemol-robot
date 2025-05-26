*** Settings ***
Documentation    Arquivo contendo as principais Keywords para os testes Web
Library    SeleniumLibrary

*** Variables ***
${APP_URL}      https://automacao.qacoders.dev.br/login
${BROWSER}      Chrome

${btn_login}      button[id=login]
${input_email}    //*[@id="email"]
${input_senha}    //*[@id="password"]
${form_login}     /html/body/main/form
${btn_logout}    nav > button
${login_wrong}    div[role=alert]


*** Keywords ***
Realizar Login
    [Documentation]    Keyword usada para realizar login, é obrigatorio 2 argumentos: [senha] e [email]
    [Arguments]    ${email}    ${senha}
    Abrir Navegador
    Wait Until Element Is Visible    css=${btn_login}    timeout=10s
    Input Text    xpath=${input_email}    ${email}
    Input Text    xpath=${input_senha}    ${senha}
    Click Element    css=${btn_login}
    Sleep    2s
    Capture Page Screenshot

Abrir Navegador
    Open Browser    ${APP_URL}    ${BROWSER}    options=add_argument("--headless")
    Maximize Browser Window

Fechar Navegador
    Close Browser

Login
    Realizar Login    sysadmin@qacoders.com    1234@Test

Validar Elemento Visivel
    [Arguments]    ${selector}
    Wait Until Element Is Visible    css=${selector}
    Element Should Be Visible    css=${selector}
    Capture Element Screenshot    css=${selector}