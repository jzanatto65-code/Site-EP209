# EP209 · Essential Perdizes — site de divulgação

Site estático (1 página) para divulgar o studio **EP209** no Essential Perdizes, São Paulo.
Todo o conteúdo e as fotos foram extraídos do anúncio no Airbnb.

## Estrutura

```
Site EP209/
├── index.html                      → a página principal
├── catalogo-vizinhanca-ep209.html  → catálogo dos locais próximos (linkado no menu "Vizinhança")
├── assets/
│   ├── css/styles.css     → estilos
│   ├── js/main.js         → menu, galeria/lightbox, animações
│   └── img/foto-01..29.jpg → fotos do studio e do condomínio
├── scripts/serve.ps1      → servidor local para testes
└── README.md
```

> **Importante:** o link "Vizinhança" no menu aponta para `catalogo-vizinhanca-ep209.html`,
> que precisa ficar na mesma pasta do `index.html`. Ao publicar, suba os dois arquivos juntos.

## Como ver localmente

Basta abrir o `index.html` no navegador. Para testar como se fosse o site
publicado, rode o servidor incluso (PowerShell, na pasta do projeto):

```bash
powershell -ExecutionPolicy Bypass -File "scripts\serve.ps1"
```

Depois abra http://localhost:4173

## Atualizar nota e número de avaliações

A nota e o total de avaliações no topo do site (`5,0 · 9 avaliações`) ficam fixos no
`index.html` — o Airbnb não oferece uma forma automática e confiável de buscar esse
dado (a página do anúncio é renderizada via JavaScript e tem proteção antirrobô), então
a atualização é assistida: você olha o anúncio e roda o script.

1. Veja a nota e o número de avaliações atuais no anúncio do Airbnb.
2. Rode (na pasta do projeto):

```bash
powershell -ExecutionPolicy Bypass -File "scripts\atualizar-avaliacoes.ps1" -Nota 4.9 -Avaliacoes 12
```

O script substitui o trecho no `index.html` automaticamente, preservando acentuação e
formatação. Depois é só revisar o resultado e publicar/commitar normalmente.

## Como publicar (grátis)

Qualquer uma destas opções serve — é só subir a pasta inteira:

- **Netlify Drop**: https://app.netlify.com/drop (arraste a pasta)
- **Vercel**: `npx vercel` dentro da pasta
- **GitHub Pages**: suba o repositório e ative Pages na branch `main`
- **Cloudflare Pages**: conecte o repositório ou faça upload direto

## O que revisar / editar antes de publicar

| Item | Onde | Observação |
|------|------|------------|
| **Número de WhatsApp** | `index.html`, busque por `5511950571111` | Já configurado (11 95057-1111), no botão da seção "Reservas" e no botão flutuante. Para trocar, substitua o número nos dois pontos (formato `55` + DDD + número). |
| **Endereço no mapa** | `index.html`, `iframe` do Google Maps | Configurado para *Rua João Ramalho, 1041 – Perdizes*. Confirme o endereço do condomínio e ajuste o texto do `src` se necessário. |
| **Preço de referência** | `index.html`, seção "Reservas" (`R$ 303`) | Valor aproximado visto no anúncio. Ajuste ou remova se preferir não fixar preço. |
| **Link do Airbnb** | vários pontos do `index.html` | `https://www.airbnb.com.br/rooms/1728453226119477229` |
| **Avaliações** | hero (`5,0 · 9 avaliações`) | Veja a nota e o total no anúncio do Airbnb e rode o script abaixo para atualizar. |

## Domínio próprio

Depois de publicar, todos os serviços acima permitem apontar um domínio
(ex.: `ep209.com.br` ou `studioep209.com.br`) nas configurações do projeto.
