using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

public class DeckScriptV2 : MonoBehaviour
{
    public GameManagerV2 gameManagerV2;

    public Sprite cardBackSprite;
    int cardBackValue = -100;
    int cardBackCountingValue = -100;

    int currentIndex = 0;

    const int deckCount = 8;
    const int cardsInOneDeck = 52;

    public Sprite[] cardSpritesOneDeckBackup;
    Sprite[] cardSprites = new Sprite[deckCount*cardsInOneDeck];
    int[] cardValues = new int[deckCount*cardsInOneDeck];
    int[] cardCountingValues = new int[deckCount*cardsInOneDeck];

    int countCardTotal = 0;

    // Start is called before the first frame update
    void Start()
    {
        GetCardValues();
        GetCardCountingValues();
        GetNewCardSprites();
        Shuffle(); 
    }

    void GetCardValues()
    {
        int num = 0;
        // Loop to assign values to the cards
        for (int i = 0; i < cardSprites.Length; i++)
        {
            num = i + 1;
            // Count up to the amount of cards, 52
            num %= 13;
            // if there is a remainder after x/13, then remainder
            // is used as the value, unless over 10, the use 10
            if(num > 10 || num == 0)
            {
                num = 10;
            }
            cardValues[i] = num++;
        }
    }
    void GetCardCountingValues()
    {
        int num = 0;

        for (int i = 0; i < cardSprites.Length; i++) {
            num = i + 1;
            num %= 13; // K as 13 get 0 here

            if (num >= 2 && num <= 6) cardCountingValues[i] = 1;               //2-6
            else if (num >= 10 || num <= 1) cardCountingValues[i] = -1; //10-Q + A (1) + K (0)
            else cardCountingValues[i] = 0;                             // 7-9
        }

    }
    void GetNewCardSprites() {

        for (int deck = 0; deck < deckCount; deck++) {
            Sprite[] tempCardSprites = cardSpritesOneDeckBackup;

            for (int card = 0; card < tempCardSprites.Length; card++) {
                cardSprites[deck*cardsInOneDeck + card] = tempCardSprites[card];
            }
        }
    }

    public void Shuffle()
    {
        // Standard array data swapping technique
        for(int i = cardSprites.Length-1; i >= 0; --i)
        {
            int j = Mathf.FloorToInt(Random.Range(0.0f, 1.0f) * cardSprites.Length - 1) + 1;
            Sprite face = cardSprites[i];
            cardSprites[i] = cardSprites[j];
            cardSprites[j] = face;

            int value = cardValues[i];
            cardValues[i] = cardValues[j];
            cardValues[j] = value;

            int cardCountingValue = cardCountingValues[i];
            cardCountingValues[i] = cardCountingValues[j];
            cardCountingValues[j] = cardCountingValue;
        }
        currentIndex = 0;
    }

    public int DealCard(CardScript cardScript)
    {
        cardScript.SetSprite(cardSprites[currentIndex]);
        cardScript.SetValue(cardValues[currentIndex]);
        cardScript.SetCountingValue(cardCountingValues[currentIndex]);
        countCardTotal += cardScript.GetCountingValue(); //add to Count total


        cardSprites[currentIndex] = cardBackSprite; //removing card from deck
        cardValues[currentIndex] = cardBackValue;   //setting its values to cardback values
        cardCountingValues[currentIndex] = cardBackCountingValue;

        currentIndex++;
        
        CutCardCheckThanShuffle(); // Shuffle "empty" deck when approaching cut card

        return cardScript.GetValueOfCard();
    }

    public Sprite GetCardBack()
    {
        return cardBackSprite;
    }

    private void CutCardCheckThanShuffle() {
        // Cut card position index
        int cutCardIndex = 20; //how much cards left after cutCard

        // shuffle new deck when cut card
        if (currentIndex == deckCount * cardsInOneDeck - cutCardIndex) {
            GetCardValues();
            GetCardCountingValues();
            GetNewCardSprites();
            countCardTotal = 0; //reset Count after decks shuffled
            Shuffle();
        }
    }

    public double GetRemainingDeckSize() {
        int cardsRemaining = deckCount * cardsInOneDeck - currentIndex;

        double dCardsRemaining = cardsRemaining;
        double dCardsInOneDeck = cardsInOneDeck;

        double deckRemaining = dCardsRemaining/dCardsInOneDeck; // [part of the one using] 
        //deckRemaining += (deckCount-1); // [decks without the one using right now]

        return deckRemaining;
    }

    public int GetCountCardTotal() {
        return countCardTotal;
    }
}
