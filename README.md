
# Watch List App

Este projeto foi desenvolvido como parte de uma entrevista técnica, em um período de 5 dias. O foco principal foi construir um app de filmes usando Flutter e consumir a API do The Movie Database (TMDB). Durante o desenvolvimento, explorei novos conceitos da tecnologia, além de revisar e melhorar funcionalidades que já havia implementado em outros projetos.

## 📱Preview

![Splash](https://github.com/user-attachments/assets/4864cc3d-8142-4700-8770-bcaa743a9ee9)
![Home_Page](https://github.com/user-attachments/assets/e9ee094a-35b7-4f07-a78d-64ad85f8e510)
![filmes favoritados](https://github.com/user-attachments/assets/4703614f-d37f-498b-bafe-66397f6dcdf4)
![Barra de pesquisa](https://github.com/user-attachments/assets/ca33e74a-0c7d-479e-b531-f0fba9bf5025)



## 🛠️ Funcionalidades

- **Carrossel de Filmes**: Mostra filmes populares em destaque no topo da tela inicial, com um indicador de página e suporte a favoritos.
- **Lista de Filmes Favoritos**: Permite adicionar e remover filmes da lista de favoritos, que é persistida enquanto o aplicativo está em execução.
- **Detalhes dos Filmes**: Exibe informações detalhadas de cada filme, como título, sinopse, avaliação e gênero.
- **Paginação Infinita**: Carrega mais filmes automaticamente quando o usuário chega ao final da lista.
  
## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento mobile multiplataforma.
- **Dart**: Linguagem de programação usada no Flutter.
- **HTTP package**: Utilizado para fazer requisições à API do TMDB.
- **Gerenciamento de estado: Organiza a lógica de estado de forma eficiente.
  
## 📱 Telas

- **Home**: Tela inicial, que exibe o carrossel de filmes populares e uma grade de filmes.
- **MovieDetails**: Exibe informações detalhadas sobre o filme selecionado.
- **Favorites**: Lista de filmes que foram adicionados aos favoritos.


## Como Executar o Projeto

### Pré-requisitos

- Ter o Flutter instalado. Siga [essas instruções](https://flutter.dev/docs/get-started/install) para instalar o Flutter.
- Lembrar de salvar pasta pubspec.yaml pra rodar as configurações da API

### Passos

1. Clone o repositório:
   ```bash
     git clone https://github.com/brunaa-keila/WatchList.git
   cd .\WatchList\exemplo_2\
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Adicione sua chave da API do TMDB no arquivo `\lib\services\movie_services.dart`:
   ```dart
   String _apiKey = 'SUA_API_KEY';

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
- Pesquisa de Filmes: escolher o filme a partir do pesquisar.
