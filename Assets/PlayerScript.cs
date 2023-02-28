using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerScript : MonoBehaviour
{
    // --- This script is for BOTH player and dealer

    // Get other scripts
    public CardScript cardScript;   
    public DeckScriptV2 deckScript;

    // Total value of player/dealer's hand
    public int handValue = 0;

    // Betting money
    private int money = 100000;

    // Array of card objects on table
    public GameObject[] hand;
    // Index of next card to be turned over
    public int cardIndex = 0;
    // Tracking aces for 1 to 11 conversions
    List<CardScript> aceList = new List<CardScript>();

    //BasicStrategy Arrays
    string[,] BasicStrategy;
    string[,] BasicStrategyWhenAce;

    public void StartHand()
    {
        GetCard();
        GetCard();
    }

    // Add a hand to the player/dealer's hand
    public int GetCard()
    {
        // Get a card, use deal card to assign sprite and value to card on table
        int cardValue = deckScript.DealCard(hand[cardIndex].GetComponent<CardScript>());
        // Show card on game screen
        hand[cardIndex].GetComponent<Renderer>().enabled = true;
        // Add card value to running total of the hand
        handValue += cardValue;
        // If value is 1, it is an ace
        if(cardValue == 1)
        {
            aceList.Add(hand[cardIndex].GetComponent<CardScript>());
        }
        // Check if we should use an 11 instead of a 1
        AceCheck();
        cardIndex++;

        return handValue;
    }

    // Search for needed ace conversions, 1 to 11 or vice versa
    public void AceCheck()
    {
        int aceCount = 0;
        // for each ace in the lsit check
        foreach (CardScript ace in aceList)
        {
            aceCount++;
            if(handValue + 10 < 22 && ace.GetValueOfCard() == 1)
            {
                // if converting, adjust card object value and hand
                ace.SetValue(11);
                handValue += 10;
            } else if (handValue > 21 && ace.GetValueOfCard() == 11)
            {
                // if converting, adjust gameobject value and hand value
                ace.SetValue(1);
                handValue -= 10;
            }
        }
    }

    // Add or subtract from money, for bets
    public void AdjustMoney(int amount)
    {
        money += amount;
    }

    // Output players current money amount
    public int GetMoney()
    {
        return money;
    }

    // Hides all cards, resets the needed variables
    public void ResetHand()
    {
        for(int i = 0; i < hand.Length; i++)
        {
            hand[i].GetComponent<CardScript>().ResetCard();
            hand[i].GetComponent<Renderer>().enabled = false;
        }
        cardIndex = 0;
        handValue = 0;
        aceList = new List<CardScript>();
    }

    // ---------------------------------------------------------

    public string[,] ReadFromBasicStrategy() //csv
    {
        BasicStrategy = new string[102, 4];

        //string path = @"C:\Users\humosz\Desktop\Hubert\AGH\BlackjackBasic.csv";
        string path = @"C:\Users\humosz\Downloads\BlackjackBasicAIoutput.csv";
        string fileData = System.IO.File.ReadAllText(path);
        string[] lines = fileData.Split('\n');

        for (int line = 0; line < lines.Length; line++)
        {
            string[] lineData = (lines[line].Trim()).Split(',');

            for (int data = 0; data < lineData.Length; data++)
            {
                BasicStrategy[line, data] = lineData[data];
                //Debug.Log(BasicStrategy[line, data].ToString()); // SYNTAX FOR DEBUG / DEBUGGING / CONSOLE WRITE
            }
        }

        return BasicStrategy;
    }


    public string[,] ReadFromBasicStrategyWhenAce() //csv
    {
        BasicStrategyWhenAce = new string[82, 4];

        //string path = @"C:\Users\humosz\Desktop\Hubert\AGH\BlackjackIfAce.csv";
        string path = @"C:\Users\humosz\Downloads\BlackjackIfAceAIoutput.csv";
        string fileData = System.IO.File.ReadAllText(path);
        string[] lines = fileData.Split('\n');

        for (int line = 0; line < lines.Length; line++)
        {
            string[] lineData = (lines[line].Trim()).Split(',');

            for (int data = 0; data < lineData.Length; data++)
            {
                BasicStrategyWhenAce[line, data] = lineData[data];
            }
        }

        return BasicStrategyWhenAce;
    }

    public string ReturnBSMove(bool haveAce, int dealerCard, int card1, int card2, int handValue) { // first handvalue is card1+card2, than other cards are added if hit clicked
        string move = "H";
        string[,] BSdata;

        // BLACKJACK
        bool blackjack = false;
        if (card1+card2 == 21) {
            blackjack = true; 
            move = "S";

            //Debug When Blackjack
            Debug.Log("Ace:"+haveAce+" Blackjack:"+blackjack+" --> "+"Dealer:"+dealerCard+", Cards:"+card1+","+card2+" --> "+move);

            return move;
        }

        if (haveAce) { 
            BSdata = BasicStrategyWhenAce;

            int dealerFirstCardIndex = (dealerCard-2)*8 + 1; //8 moves possible per dealer card
            int cardTotalIndex;
                
            if (card1 == 11) {
                cardTotalIndex = dealerFirstCardIndex + (card2-2);
            } 
            else if (card2 == 11) {                
                cardTotalIndex = dealerFirstCardIndex + (card1-2);
            }
            else { //shouldn't happen
                cardTotalIndex = 1;
                Debug.Log("ERROR! Sth went wrong with returning move with Aces in PlayerScript/ReturnBSMove.cs. CHECK!");
            }
            move = BSdata[cardTotalIndex, 2].ToString();
                
            if ((card1 == 11 && card2 == 1) || (card2 == 11 && card1 == 1)) move = "H"; //when 2 aces

        } else if (card1+card2 >= 8 && card1+card2 <= 17) { // Basic Strategy 1st table works for 8-17 total
            BSdata = BasicStrategy;

            int dealerFirstCardIndex = (dealerCard-2)*10 + 1; //10 moves possible per dealer card

            int cardTotal = card1 + card2;
            int cardTotalIndex = dealerFirstCardIndex + (cardTotal-8);

            move = BSdata[cardTotalIndex, 2].ToString();
        }

        // other safety checks
        if (card1+card2 > 17 && haveAce == false) move = "S"; // Stand if hand is 18 and without aces
        if (card1+card2 < 8) move = "H";

        //--    --      --      --      --      --      --
        //------------ after hit is clicked ---------------

        // check total (othercardsum > 0) from BS again (if between 8 and 17) and make move
        if(handValue != card1+card2 && (handValue >= 8) && (handValue <= 17)) { // Basic Strategy 1st table works for 8-17 total
            BSdata = BasicStrategy;

            int dealerFirstCardIndex = (dealerCard-2)*10 + 1; //10 moves possible per dealer card

            int cardTotal = handValue;
            int cardTotalIndex = dealerFirstCardIndex + (cardTotal-8);

            move = BSdata[cardTotalIndex, 2].ToString();
        } else if (handValue != card1+card2 && (handValue > 17)) move = "S"; //if cardTotal is >17 - stand

        //Debug Basic Strategy move and stuff
        //Debug.Log("Ace:"+haveAce+" Blackjack:"+blackjack+" --> "+"Dealer:"+dealerCard+", Cards:"+card1+","+card2+", (others:"+(handValue-card1-card2)+") --> "+move);

        return move; // other return in BLACKJACK !
    }

}
