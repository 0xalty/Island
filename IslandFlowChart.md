# Island flow chart

```mermaid
---
title: "Island flow chart"
---

sequenceDiagram
  participant Artist
  participant Island(DAPPS)
  participant Island contract
  participant Curator
  participant Buyer

  Note over Artist, Island(DAPPS): 1. Mint Artwork (UX)
  Artist ->> Island(DAPPS): Mint Artwork
  Island(DAPPS) ->> Island contract: Register Artwork with Token ID

  Note over Island contract: 3. Associate Token ID with Wallet Address
  Island(DAPPS) ->> Island contract: Display Artworks (UI)

  Note over Curator, Island(DAPPS): 5. Introduce Artwork (UX)
  Curator ->> Island(DAPPS): Introduce Artwork
  Island(DAPPS) ->> Island contract: Associate Token ID with Curator

  Note over Buyer: 7. Purchase NFT (UX)
  Buyer ->> Island contract: Purchase NFT

  Note over Island contract: 8. Distribute ETH to Artist and Curator
  Island contract ->> Artist: Distribute ETH
  Island contract ->> Curator: Distribute ETH
