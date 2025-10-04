# KIP – Agente de IA Negociador para Serviços de Assinatura

O KIP é um agente inteligente de IA Negociadora, projetado para atuar como consultor, negociador e gestor de relacionamento entre clientes e serviços digitais do ecossistema Bemobi Pay (como operadoras, streaming, aplicativos e fintechs).

Ele resolve um dos maiores problemas do mercado de assinaturas: planos engessados, renegociações lentas e perda de clientes por falta de personalização.

Com o KIP, cada cliente recebe planos sob medida, aumentando a satisfação, reduzindo churn e inadimplência, e garantindo maior receita recorrente para empresas. A ideia nasceu durante o Hackathon Bemobi através da TechSphere, com foco em inovação no ecossistema de pagamentos recorrentes.

## O Problema

- **75,3%** dos usuários já trocaram de serviço porque encontraram opções mais flexíveis em concorrentes.
- **69,8%** descrevem renegociações de planos como lentas e frustrantes.

Operadoras e empresas perdem receita com:
- Clientes desistindo de fechar planos.
- Inadimplência e churn.
- Alto custo de renegociações manuais.

## A Solução – KIP

Um agente de IA que combina negociação, retenção e inteligência de relacionamento para transformar pagamentos recorrentes em relacionamentos duradouros.

## Funcionalidades

- **Assinatura Inteligente**:
    - O cliente informa suas necessidades e orçamento.
    - A IA cruza a demanda, o limite financeiro e a margem do parceiro.
    - Retorna uma proposta personalizada e viável.

- **Gestão de Retenção e Inadimplência**:
    - Em caso de cancelamento, oferece alternativas sob medida (desconto, pausa, troca de plano).
    - Para inadimplentes, propõe downgrade automático (premium → básico).

- **Perfil Dinâmico de Relacionamento (Score Inteligente)**:
    - Analisa o histórico de pagamento.
    - Mede o engajamento com o serviço.
    - Avalia o potencial de fidelidade e o valor de longo prazo do cliente.

## Arquitetura do KIP

- **Frontend**: Chat interativo construído com Flutter para negociação com o cliente.
- **Backend**: Dart e Gemini API processam os dados do usuário e geram propostas personalizadas. **Acesse o repositório aqui:** https://github.com/leticia-farias/backend_assistente
- **Banco de Dados**: PostgreSQL para armazenar perfis de clientes, histórico de interações e o score dinâmico.

## Estrutura do Projeto

O projeto é organizado da seguinte forma para garantir escalabilidade e manutenção:

```bash
/lib
├── /core
│   ├── /layout          # Widgets de layout responsivo (BaseLayout)
│   ├── /theme           # Definições de cores, estilos de texto e espaçamento
├── /models              # Modelos de dados (Package, ChatMessage)
├── /screens             # Telas principais da aplicação
├── /services            # Lógica de comunicação com a API (AssistantService)
├── /widgets             # Componentes reutilizáveis (botões, inputs, cards)
└── app.dart             # Configuração principal do MaterialApp
```

- **`core`**: Contém a lógica central e reutilizável da aplicação, como temas e layouts base.
- **`models`**: Define as classes que estruturam os dados, como `Package` para os planos e `ChatMessage` para as mensagens do chat.
- **`screens`**: Cada arquivo representa uma tela, como `onboarding_screen.dart`, `chat_screen.dart`, `login_screen.dart`, e `score_screen.dart`.
- **`services`**: Isola a comunicação com serviços externos, como a API do backend.
- **`widgets`**: Armazena componentes de UI customizados e reutilizáveis em várias telas.

## Casos de Uso para Teste

Para simular diferentes jornadas de usuário, utilize os cenários abaixo:

### 1. Cliente Novo
Este fluxo simula a experiência de um novo usuário que ainda não possui conta.

1.  **Tela Inicial**: Na tela de onboarding, descreva o que você precisa no campo de texto.
    - *Exemplo*: "Quero um plano de internet para casa com boa velocidade para jogos e home office, mas não posso gastar mais de R$ 100."
2.  **Sugestão de Plano**: A IA irá analisar sua necessidade e orçamento e retornará com uma ou mais sugestões de planos.
3.  **Aceitar a Oferta**: Ao clicar em "Aceitar" em um dos cards de sugestão, você será direcionado para a tela de cadastro.
4.  **Cadastro**: Preencha os campos com seus dados (nome, e-mail, telefone, senha) e finalize o cadastro.
5.  **Tela de Score**: Após o cadastro, você será levado a uma tela de boas-vindas, informando que seu score de relacionamento ainda está sendo calculado.

### 2. Cliente Bom
Este fluxo simula um cliente com bom histórico de pagamentos, que tem acesso a um score positivo.

1.  **Login**: Na tela inicial, clique em "**Já tem uma conta? Faça login**".
2.  **Credenciais**:
    - **Email**: `bom@email.com`
    - **Senha**: `123`
3.  **Tela de Score**: Você será direcionado para a tela de Score, onde poderá visualizar uma pontuação alta (Excelente), indicando um bom relacionamento com a empresa.
4.  **Navegação**: A partir daí, você pode iniciar um novo chat para renegociar ou explorar outras opções.

### 3. Cliente Inadimplente
Este fluxo simula um cliente com histórico de pagamentos negativo, resultando em um score baixo.

1.  **Login**: Na tela inicial, clique em "**Já tem uma conta? Faça login**".
2.  **Credenciais**:
    - **Email**: `inadimplente@email.com`
    - **Senha**: `123`
3.  **Tela de Score**: Você será direcionado para a tela de Score, onde verá uma pontuação baixa (Baixo ou Médio), refletindo um relacionamento que precisa de atenção. A IA pode usar essa informação para oferecer propostas de renegociação mais adequadas.
4.  **Navegação**: O cliente pode iniciar um novo chat para tentar negociar sua situação ou explorar planos mais econômicos.

## Equipe TechSphere

- [Alanna Machado](https://github.com/AlannaFM)
- [Eduarda Leal](https://github.com/eduardaleall)
- [Kauã Rizzo](https://github.com/rizzoka)
- [Letícia Farias](https://github.com/leticia-farias)
