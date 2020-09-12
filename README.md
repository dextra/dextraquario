# Dextraquário :fish:
### https://dextra.github.io/dextraquario

### Para comemorar o **Dx DevDay** (12/set), durante todo o mês de Setembro teremos o **Dextraquário** :fish:.

Queremos incentivar a essência programadora incansável que existe dentro de cada um de vocês, premiando quem mais colaborar! :trophy:

Confira todas as regras em nosso [REGULAMENTO](https://drive.google.com/file/d/1km2JxZgbeSivb5_uaYCfuWdXi5sbyPV4/view?usp=sharing)

Se tiver qualquer dúvida, basta abrir um issue nesse mesmo repositório

## Como participar? 
### Ao participar de qualquer ação, você pode abrir um Pull Request nesse repositório, seguindo os passos abaixo:

1. Criar um diretório  com o seu nome completo dentro de `contributions`
    - Caso seja a primeira submissão, do contrário pode utilizar o diretório existente
2. Dentro desse diretório, criar um arquivo JSON seguindo o modelo abaixo
    - Você pode criar um arquivo com qualquer nome, sugerimos usar um número sequencial com o nome do arquivo, exemplo: `contribuicao-1.json`

```javascript
{
  "name": "Nome da pessoa",	
  // Available colors: [BLUE, RED, GREEN, YELLOW, PINK]
  "fishColor": "BLUE", 
  // Available contributions: [DESAFIO_TECNICO, ENTREVISTA_PARTICIPACAO, ENTREVISTA_AVALIACAO_TESTE, CAFE_COM_CODIGO, CONTRIBUICAO_COMUNIDADE, ARTIGO_BLOG_DEXTRA, CHAPA]
  "contributionType": "CAFE_COM_CODIGO", 
  "contributionDescription": "Descrição do item com no máximo 140 caracteres",
  // If contributionType in [DESAFIO_TECNICO, CONTRIBUICAO_COMUNIDADE] 
  "contributionLinkRepository": "" 
}
```
3. Abrir o Pull Request 
    - Se tiver dúvidas em como abrir o Pull Request, pode consultar o passo a passo [**aqui**](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork).

Obs.: Após cada merge de PR no Dextraquário um GH Actions faz a atualização automática dos peixinhos, devido ao cache dos browsers e do GH pages seu peixinho pode demorar um pouco para aparecer. 

### Quando a comissão mergear sua primeira requisição, você ganha um peixinho no **Dextraquário** :fish:. Você pode conferir o estado da competição por aqui https://dextra.github.io/dextraquario.

### Quanto mais ações você realizar, mais seu peixinho cresce. No fim do mês de setembro, os 3 maiores peixes serão premiados.

## Aviso :warning:
Tenha em mente que esse evento é apenas uma brincadeira, organizada pelos seus próprios colegas de trabalho. Considerando os valores da empresa de colaboração e transparência nas relações, esperamos não nos preocupar com trapaças e/ou artimanhas baseadas em brechas do regulamento, apesar disso a comissão se reserva no direito de tomar a decisão em como agir caso irregularidades sejam identificadas. Se tiver qualquer dúvida, procure as pessoas responsáveis.
