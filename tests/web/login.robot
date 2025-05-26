*** Settings ***
Resource    ../../resources/common.resource
Resource    ../../resources/web.robot

*** Test Cases ***
CT001 - Realizar Login com sucesso
    [Tags]    Regressao
    web.Realizar Login    sysadmin@qacoders.com    1234@Test
    Validar Elemento Visivel    ${btn_logout}
    Fechar Navegador
    
CT002 - Realizar Login som senha invalida 
    [Tags]    Smoke
    web.Realizar Login    sysadmin@qacoders.com    1234@Test1
    Validar Elemento Visivel    ${login_wrong}
    Fechar Navegador

CT003 - Realizar Login com email invalido
    [Tags]    Smoke
    web.Realizar Login    sysadmin@qacoders.com.br    1234@Test
    Validar Elemento Visivel    ${login_wrong}
    Fechar Navegador

CT004 - Realizar Logout com sucesso
    [Tags]  Regressao
    web.Login
    Validar Elemento Visivel    ${btn_logout}
    Click Element    css=${btn_logout}
    Wait Until Element Is Visible    css=${btn_login}
    Validar Elemento Visivel    ${btn_login}
    Fechar Navegador