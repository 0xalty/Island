# Island flow chart

```mermaid
---
title: "Island flow chart"
---

sequenceDiagram
  participant Artist
  participant Island(DApps)
  participant Island contract
  participant Curator
  participant Buyer

  Note over Artist, Island(DApps): 1. Mint Artwork (UX)
  Artist ->> Island(DApps): Mint Artwork
  Island(DApps) ->> Island contract: Register Artwork with Token ID

  Note over Island contract: 3. Associate Token ID with Wallet Address
  Island(DApps) ->> Island contract: Display Artworks (UI)

  Note over Curator, Island(DApps): 5. Introduce Artwork (UX)
  Curator ->> Island(DApps): Introduce Artwork
  Island(DApps) ->> Island contract: Associate Token ID with Curator

  Note over Buyer: 7. Purchase NFT (UX)
  Buyer ->> Island contract: Purchase NFT

  Note over Island contract: 8. Distribute ETH
