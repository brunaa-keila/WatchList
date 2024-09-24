
# Watch List App

Este projeto foi desenvolvido como parte de uma entrevista técnica, em um período de 5 dias. O foco principal foi construir um app de filmes usando Flutter e consumir a API do The Movie Database (TMDB). Durante o desenvolvimento, explorei novos conceitos da tecnologia, além de revisar e melhorar funcionalidades que já havia implementado em outros projetos.

## Preview

![Screenshot do App](link_da_imagem)

## Funcionalidades

- **Carrossel de Filmes**: Mostra filmes populares em destaque no topo da tela inicial, com um indicador de página e suporte a favoritos.
- **Lista de Filmes Favoritos**: Permite adicionar e remover filmes da lista de favoritos, que é persistida enquanto o aplicativo está em execução.
- **Detalhes dos Filmes**: Exibe informações detalhadas de cada filme, como título, sinopse, avaliação e gênero.
- **Pesquisa de Filmes**: Possibilidade de buscar por filmes diretamente na API do TMDB.
- **Paginação Infinita**: Carrega mais filmes automaticamente quando o usuário chega ao final da lista.
  
## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento mobile multiplataforma.
- **Dart**: Linguagem de programação usada no Flutter.
- **HTTP package**: Utilizado para fazer requisições à API do TMDB.
- **Gerenciamento de estado com GetX**: Organiza a lógica de estado de forma eficiente.
  
## Telas

- **Home**: Tela inicial, que exibe o carrossel de filmes populares e uma grade de filmes.
- **MovieDetails**: Exibe informações detalhadas sobre o filme selecionado.
- **Favorites**: Lista de filmes que foram adicionados aos favoritos.
- **Search**: Tela onde o usuário pode pesquisar por filmes.

## Como Executar o Projeto

### Pré-requisitos

- Ter o Flutter instalado. Siga [essas instruções](https://flutter.dev/docs/get-started/install) para instalar o Flutter.
- Criar uma conta no [The Movie Database](https://www.themoviedb.org/) e gerar uma chave de API.

### Passos

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   cd seu-repositorio
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Adicione sua chave da API do TMDB no arquivo `movie_services.dart`:
   ```dart
   final String _apiKey = 'SUA_API_KEY';
   ```

4. Execute o projeto:
   ```bash
   flutter run
   ```

## Estrutura do Código

- **main.dart**: Ponto de entrada do app.
- **models/**: Contém os modelos de dados como `Movie` e `MovieResponse`.
- **pages/**: Contém as diferentes telas como `HomePage`, `MovieDetailPage` e `FavoritesPage`.
- **services/**: Contém a classe `MovieServices`, responsável por fazer as requisições à API do TMDB.

## Melhorias Futuras

- Persistência de favoritos usando banco de dados local (SQLite).
- Implementar cache para melhorar a performance.
- Melhorar a interface de usuário com animações e transições mais suaves.
