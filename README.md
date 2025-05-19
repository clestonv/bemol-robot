## Robot Framework API

### 🎯 Como executar os testes com Robot Framework

Para rodar os testes, siga os passos abaixo:

1) Acesse a pasta onde os testes estão localizados (por padrão, a pasta tests):

```bash
cd tests
```

2) Acesse a pasta onde os testes estão localizados (por padrão, a pasta tests):

```bash
robot -d ../logs nome_da_suite.robot
```

ou

```bash
robot --outputdir ../logs nome_da_suite.robot
```

💡 Dicas:
- Você também pode usar ./nome_da_suite.robot no lugar de nome_da_suite.robot. O ./ indica explicitamente que o arquivo está no diretório atual, mas não é obrigatório — ambos funcionam da mesma forma se o terminal estiver na pasta correta.
- Substitua ```nome_da_suite.robot``` pelo nome do arquivo de teste que deseja executar.