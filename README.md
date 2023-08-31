# Islands
We make a marketplace where everyone becomes a curator and curation becomes a work of art.

## Statement
In a vast marketplace such as OpenSea where there are rows after rows of works belonging to mega-collectors, viewers may be discouraged from even browsing the pages to search for artworks, and lesser known artists with fewer assets tend to sink into the background.
Is there a way construct a system that allows more flexibility and fluidity in the exposure of these works so that they have a better chance at entering the global market?

We believe that blockchain technology will re-define the order constructed within the current digital ecosystem. Islands: curation media + NFT marketplace is a platform where users can curate works according to their aesthetics and create “islands” themselves, ultimately resulting in the creation of a group of archipelagos. Each island becomes a reflection of the user’s own worldview where unique cultures can flourish. When each of these islands connect and interact, the works will flow with more fluidity and will stimulate a more active movement within the market as a whole.


Island flow chart
mermaid
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



## Exhibition
![PXL_20230830_093439896](https://github.com/0xalty/Island/assets/129202655/4d10f2bd-7bb3-4428-934f-6b7bc145f1ec)
Island 2023
at CCBT - Civic Creative Base Tokyo in Shibuya.
Artists: Kumagai Akira, Takahashi Ryuta, Suzuki Yushin, Habu Kazuhito

Organised by CCBT for ‚Future Ideations Camp Vol.2 setup():

## Idea
![island_ccbt](https://github.com/0xalty/Islands/assets/129202655/8b14ffa9-09b6-40ae-a3e7-3e512d8c7f31)


**Tell us what you guys thinking. Let's create a market where we can all be truly P2P!**
