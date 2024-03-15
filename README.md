# Online-Auction-System

## Overview:
This is a three-tier application that consists of the following:
- Presentation Tier: User interface to make requests, provide inputs, and see the results
- Middle Tier: Application Logic
- Data Management Tier: Database Management

## Project Specification:
- Support a company that lets users buy and sell items in online auctions.
- Allow the seller to post an item for sale, starting an auction, which will close at a specified date and time.
- Allow the seller to also post an initial price, an increment for bids, and secret minimum price.
- Enable potential buyers to post bids as part of an auction.
- Declare the user with the highest bid at the closing time of an auction as the winner (the user gets to the buy that item on the auction).
- Implement automatic bidding: buyer could set a secret upper limit on how much they are willing to pay (everytime someone pays higher than a buyer's current bid, the computer should automatically put in a higher bid for the buyer who chose the automatic bidding option, until his upper limit is not reached).

## Role Specific Tasks:
  ### End Users:
  - Should be able to create and delete accounts, and be able to login and logout of their accounts.
  - Search list of items available in auctions based on fields describing the item.
  - Set alerts for items they are interested in.
  - Be able to view history of bids for any specific auction.
  - Be able to see a list of auctions a specific buyer/seller has participated in.
  - Be able to see similar items available on auction.
  ### Customer Representatives:
  - Available to the end users for answering questions
  - Modify any information
  - Remove Illegal Auctions
  ### One administrative staff member:
  - Create accounts for customer representatives
  - Generate summary sales reports
    - Total earnings per {item, item-type, end-user}
    - Best selling {items, end-users}
  
## Technology/Tools used:
- HTML: Used to code the user interface
- Java, Javascript: Used in coding Java Servlet Pages (JSPs) that are helpful in buiding applications that serve dynamic content.
- Tomcat Server: A compatible web server with a servlet container to deploy and run java servlet pages.
- JDBC driver: An interface that allows to communicate with the relational database (connecting to the database, querying the database, processing the results, etc.)
- mySQL: Querying language to create and manage the database on the backend.
- IDEA used: Eclipse

### SEE THE MAIN BRANCH FOR THE APPLICATION CODE

### IMPORTANT NOTE: This is a project that is done exclusively as part of a Rutgers Computer Science class and cannot be plagiarized, please refer to the Rutgers Academic Integrity Policy before committing to any action.

  

