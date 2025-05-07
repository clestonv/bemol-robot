*** Settings ***
Documentation    Suite Testes de Login
Resource    ../resources/common.resource

*** Test Cases ***
CT001 - Login com Sucesso
    ${token}    Pegar Token
    Get Users    token=${token}

CT002 - Login com Email invalido
    ${resposta}    Realizar Login    login_email=teste@gmail.com    login_senha=${senha_admin}
    Should Be Equal    first=E-mail ou senha informados são inválidos.    second=${resposta.json()["alert"]}
    Validar Mensagem Login    mensagem_esperada=E-mail ou senha informados são inválidos.    mensagem_resposta=${resposta.json()["alert"]}
    Should Contain    container=${resposta.json()["alert"]}    item=E-mail ou senha informados são inválidos
    
CT003 - Login com Senha invalida
    ${resposta}    Realizar Login    login_email=${email_admin}    login_senha=123412354125
    Should Be Equal    first=E-mail ou senha informados são inválidos.    second=${resposta.json()["alert"]}
    Validar Mensagem Login    mensagem_esperada=E-mail ou senha informados são inválidos.    mensagem_resposta=${resposta.json()["alert"]}
    Should Contain    container=${resposta.json()["alert"]}    item=E-mail ou senha informados são inválidos
CT004 - Login com Email e Senha em branco
    ${resposta}    Realizar Login    login_email=       login_senha=    
    Should Be Equal    first=O campo e-mail é obrigatório.    second=${resposta.json()["mail"]}
    Should Be Equal    first=O campo senha é obrigatório.    second=${resposta.json()["password"]}

    