*** Settings ***
Resource    ../../resources/common.resource
Resource    ../../resources/web.robot
*** Test Cases ***
CT001 - Validar exibição Empresa
    Realizar Login Com Sucesso
    Clicar e Validar Elemento    elemento_click=${btn_cadastros}    elemento_visivel=${btn_empresa}    print_element=${drawer}  

CT002 - Validar exibição Cliente
    Realizar Login Com Sucesso
    Clicar e Validar Elemento    elemento_click=${btn_cadastros}    elemento_visivel=${btn_cliente}    print_element=${drawer}  
CT003 - Validar exibição Usuários
    Realizar Login Com Sucesso
    Clicar e Validar Elemento    elemento_click=${btn_cadastros}    elemento_visivel=${btn_usuarios}    print_element=${drawer} 

CT004 - Validar exibição Diretorias
    Realizar Login Com Sucesso
    Clicar e Validar Elemento    elemento_click=${btn_cadastros}    elemento_visivel=${btn_diretorias}    print_element=${drawer}
CT005 - Validar exibição Centro de Custo
    Realizar Login Com Sucesso
    Clicar e Validar Elemento    elemento_click=${btn_cadastros}    elemento_visivel=${btn_centrocusto}    print_element=${drawer}
CT006 - Validar exibição Departamento
    Realizar Login Com Sucesso
    Clicar e Validar Elemento    elemento_click=${btn_cadastros}    elemento_visivel=${btn_departamento}    print_element=${drawer}


*** Keywords ***
Clicar e Validar Elemento
    [Arguments]    ${elemento_click}    ${elemento_visivel}    ${print_element}
    Wait Until Element Is Visible    css=${elemento_click}    timeout=10
    Click Element    css=${elemento_click}
    Capture Page Screenshot
    Wait Until Element Is Visible    css=${elemento_visivel}
    Element Should Be Visible    css=${elemento_visivel}
    Capture Element Screenshot    css=${print_element}