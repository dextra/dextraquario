# Dextraquário
A ideia era registrar a contribuição das pessoas, ter um controle de aprovação e exibir esse ranking de forma gráfica com tema de aquário.

## Ferramentas
Flutter e Github actions

## Como funciona:
O aquário é montado com base no arquivo `dextraquario/assets/fishes.json` que é alimentado conforme o fluxo abaixo:

### Submissão de um novo peixe
A pessoa abre um PR com o JSON da contribuição de acordo com o readme do projeto.
Nesse momento, uma action de linter (`dextraquario/.github/workflows/contribution-linter.yml`) é executada para validar o formato e informações do arquivo. Se o linter quebrar, o PR fica com um aviso de inconsistência.

### Aprovação do peixe e atualização do ranking
Quando o PR é aprovado e os arquivos entram na master, a action de publicação (`dextraquario/.github/workflows/gh-pages.yml`) é executada. Nela, o script `./scripts/build_json_file.dart` transforma todos os arquivos do diretório contributions em um arquivo único (`fishes.json`) que é lido pelo aquário.
Logo em seguida, o projeto é republicado no GHPages.
