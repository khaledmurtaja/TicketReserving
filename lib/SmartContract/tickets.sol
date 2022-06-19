// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
 contract Ticket{
    uint256 TicketPrice=0.01 ether;
    uint256[] public Reserved_Tickets;// this array indicates amount of tickets which has been bought for each transaction
    string[] public movieNames;// this array indicates names of movie for each transaction
    uint256 public numberOfAvaialbeTickets=3000; // this variable indicates the available tickets to buy
    uint256 maxTicketsToBuy=9;

// this function is used for buying tickets, it must have number of tickets to reserve, and the movie name
    function BuyTicket(uint256  Amount,string memory movieName) payable public{
       require(msg.value >= TicketPrice*Amount);
       require(Amount<=maxTicketsToBuy&&Amount<=numberOfAvaialbeTickets);
       Reserved_Tickets.push(Amount);
        movieNames.push(movieName);
        numberOfAvaialbeTickets-=Amount;

    }
    // this function is for returning the numOfTickets Array
    function getReservedTicketsArray()public view returns(uint256[] memory){
        return (Reserved_Tickets);

    }
    // this function is foR returning the movies array
     function getMoviesNamesArray()public view returns(string[] memory){
        return (movieNames);

    }
     function getNumberOfAvailableTickets()public view returns(uint256){
        return (numberOfAvaialbeTickets);

    }




}
