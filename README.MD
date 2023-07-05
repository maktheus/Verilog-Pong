# Pong Game

Este é um projeto de um jogo de Pong desenvolvido em Verilog para a placa DE2-115.

## Descrição

O jogo de Pong é um clássico jogo eletrônico de raquete em que os jogadores controlam as raquetes para rebater a bola e marcar pontos. Neste projeto, o jogo é implementado utilizando a linguagem de descrição de hardware Verilog e é executado na placa DE2-115.

O jogo consiste em duas raquetes, controladas pelos jogadores, que podem mover-se verticalmente na tela para rebater a bola. Os jogadores ganham pontos quando a bola ultrapassa a raquete do oponente. O jogo continua até que um jogador alcance a pontuação máxima ou o jogo seja reiniciado manualmente.

## Funcionalidades

- Movimento das raquetes controladas pelos jogadores usando as teclas de controle.
- Colisão e rebatimento da bola nas raquetes.
- Contagem de pontos para cada jogador.
- Exibição dos placares na tela por meio da saída VGA.

## Configuração da Placa

Para executar o jogo na placa DE2-115, siga as instruções abaixo:

1. Conecte a placa DE2-115 ao computador usando o cabo USB.
2. Carregue o código Verilog na placa utilizando o software de programação adequado.
3. Conecte a placa a um monitor VGA usando um cabo VGA.
4. Ligue a placa e o monitor.
5. Use as teclas de controle para mover as raquetes e rebater a bola.

## Limitações

- A funcionalidade de exibição dos placares na tela por meio da saída VGA não foi implementada devido a restrições de tempo. No entanto, a estrutura básica para essa funcionalidade está descrita no código, fornecendo um ponto de partida para futuras implementações.

## Autores

- [Matheus Serrao Uchoa](https://github.com/maktheus)
- [Pedro Victor dos Santos Oliveira](https://github.com/pedrolievra)

## Licença

Este projeto é licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT).
