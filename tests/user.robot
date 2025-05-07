*** Settings ***
Documentation    Suite Testes de Usuarios
Resource    ../resources/common.resource

*** Test Cases ***
CT001 - Listar Usuarios com Sucesso
    ${token}    Pegar Token
    ${resposta}    Get Users    ${token}
    Status Should Be    expected_status=200    response=${resposta}

CT002 - Não deve listar usuário sem o uso de Token
    ${resposta}    Get Users    ${fake_token}
    Validar Mensagem Login    mensagem_esperada=Failed to authenticate token.    mensagem_resposta=${resposta.json()["errors"][0]}
    Status Should Be    expected_status=403    response=${resposta}

CT003 - Validar Contagem de Usúarios com Sucesso
    ${token}    Pegar Token
    ${resposta}    Count Users    ${token}
    Status Should Be    expected_status=200    response=${resposta}

CT004 - Validar Contagem de Usuários sem Token
    ${resposta}    Count Users    ${fake_token}
    Log To Console    ${resposta.json()}
    Status Should Be    expected_status=403    response=${resposta}

    # Should Not Be Empty    ${resposta.json()["count"]}