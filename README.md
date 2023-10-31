<!--
*** Thanks for checking out the Island. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! 
-->
<div id="top"></div>

[![Solidity](https://custom-icon-badges.herokuapp.com/badge/Solidity-AA6746.svg?logo=Solidity&logoColor=white)]()
# Island　
We make a marketplace where everyone becomes a curator and curation becomes a work of art.

### Issue
OpenSea and other marketplaces simply list the price of the artwork, its transition, the number of sales, TVL, etc., and do not provide captions such as the artist's thoughts and feelings about the artwork.
**They are limited to functioning as simple sales offices.**

### Solution
Consideration of high-lighting methods for artists and works that do not depend on name recognition.
- Create a mechanism to visualize democratic evaluation that does not depend on name recognition.
- Create a system that facilitates recognition of the taste and claims of the work.
- To establish a motivation for collectors and curators to search for artists and artworks. Establish motivation for collectors and curators to search for artists and artworks.
- Provide an opportunity to lead users from one work or one artist to other works or other artists. Provide an opportunity to lead users from one work or one artist to other works or other artists.

## Island Ecosystem
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
```
<p align="right">(<a href="#top">back to top</a>)</p>

## Idea
![island_ccbt](https://github.com/0xalty/Islands/assets/129202655/8b14ffa9-09b6-40ae-a3e7-3e512d8c7f31)


**Tell us what you guys thinking. Let's create a market where we can all be truly P2P!**
<p align="right">(<a href="#top">back to top</a>)</p>



## Exhibition
![PXL_20230830_093439896](https://github.com/0xalty/Island/assets/129202655/4d10f2bd-7bb3-4428-934f-6b7bc145f1ec)
Island 2023
at CCBT - Civic Creative Base Tokyo in Shibuya.
Artists: Kumagai Akira, Takahashi Ryuta, Suzuki Yushin, Habu Kazuhito
[![Github](https://img.shields.io/badge/--FFFFFF?style=social&logo=github&label=Follow%200xalty)](https://github.com/0xalty)
[![Github](https://img.shields.io/badge/--FFFFFF?style=social&logo=github&label=Follow%20YushinSuzuki)](https://github.com/YushinSuzuki)

Organised by CCBT for ‚Future Ideations Camp Vol.2 setup():

## Statement
In a vast marketplace such as OpenSea where there are rows after rows of works belonging to mega-collectors, viewers may be discouraged from even browsing the pages to search for artworks, and lesser known artists with fewer assets tend to sink into the background.
Is there a way construct a system that allows more flexibility and fluidity in the exposure of these works so that they have a better chance at entering the global market?

We believe that blockchain technology will re-define the order constructed within the current digital ecosystem. Islands: curation media + NFT marketplace is a platform where users can curate works according to their aesthetics and create “islands” themselves, ultimately resulting in the creation of a group of archipelagos. Each island becomes a reflection of the user’s own worldview where unique cultures can flourish. When each of these islands connect and interact, the works will flow with more fluidity and will stimulate a more active movement within the market as a whole.
<p align="right">(<a href="#top">back to top</a>)</p>

