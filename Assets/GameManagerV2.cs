using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class GameManagerV2 : MonoBehaviour
{
    // Game Buttons
    public Button dealBtn;
    public Button hitBtn;
    public Button standBtn;
    public Button betBtn;

    public Button retryBtn;

    public KeyCode dealKey;
    public KeyCode hitKey;
    public KeyCode standKey;
    public KeyCode betKey;

    public KeyCode retryKey;

    private int standClicks = 0;

    // Access the player and dealer's script
    public PlayerScript playerScript;
    public PlayerScript dealerScript;
    public AIControllerScript aiControllerScript;

    // public Text to access and update - hud
    public TMP_Text playerHandText;
    public TMP_Text dealerHandText;
    public TMP_Text betsText;
    public TMP_Text cashText;
    public TMP_Text mainText;
    public TMP_Text standBtnText;

    // Card hiding dealer's 2nd card
    public GameObject hideCard;
    // How much is bet -> dealer matches that one, making it x2
    int pot = 40; // for first game - $20 bet
    const int potConstValue = 40;
    int bets = 0;

    public TMP_Text deckSizeText;
    public TMP_Text cardCountText;

    // counters
    const int maxGamesCount = 250; // in AIcs set to be able to do around 10000 max games.
    int games = 0;
    int wins = 0;
    int looses = 0;
    int pushes = 0;


    void Start()
    {
        // Add on click listeners to the buttons
        dealBtn.onClick.AddListener(() => DealClicked());
        hitBtn.onClick.AddListener(() => HitClicked());
        standBtn.onClick.AddListener(() => StandClicked());
        betBtn.onClick.AddListener(() => BetClicked());

        dealBtn.gameObject.SetActive(true);
        hitBtn.gameObject.SetActive(false);
        standBtn.gameObject.SetActive(false);
        mainText.gameObject.SetActive(true);
        playerHandText.gameObject.SetActive(false);
        dealerHandText.gameObject.SetActive(false);
        hideCard.GetComponent<Renderer>().enabled = false;

        // testing with retry couse unity crashes after more than 250 games
        retryBtn.onClick.AddListener(() => DealClicked());
        retryBtn.gameObject.SetActive(false);

        for(int i = 0; i < playerScript.hand.Length; i++)
        {
            playerScript.hand[i].GetComponent<CardScript>().ResetCard();
            playerScript.hand[i].GetComponent<Renderer>().enabled = false;
        }
        for(int i = 0; i < dealerScript.hand.Length; i++)
        {
            dealerScript.hand[i].GetComponent<CardScript>().ResetCard();
            dealerScript.hand[i].GetComponent<Renderer>().enabled = false;
        }

        string[,] BasicStrategy = playerScript.ReadFromBasicStrategy();
        string[,] BasicStrategyWhenAce = playerScript.ReadFromBasicStrategyWhenAce();
    }

    private void DealClicked() {
        // Reset round, hide text, prep for new hand
        playerScript.ResetHand();
        dealerScript.ResetHand();
        // Hide deal hand score at start of deal
        dealerHandText.gameObject.SetActive(false);
        playerHandText.gameObject.SetActive(true);
        betBtn.gameObject.SetActive(false);
        // Hide main text
        mainText.gameObject.SetActive(false);
        // Hide decksize and cardcount
        //deckSizeText.gameObject.SetActive(false);
        //cardCountText.gameObject.SetActive(false);
        //GameObject.Find("DeckCard").GetComponent<DeckScriptV2>().Shuffle(); //shuffling done in DeckScriptV2 when dealing card
        playerScript.StartHand();
        dealerScript.StartHand();    
        // Update the scores displayed
        playerHandText.text = "Hand: " + playerScript.handValue.ToString();
        dealerHandText.text = "Hand: " + dealerScript.handValue.ToString();
        // Place card back on dealer card, hide card
        hideCard.GetComponent<Renderer>().enabled = true;
        // Adjust buttons visibility
        dealBtn.gameObject.SetActive(false);
        hitBtn.gameObject.SetActive(true);
        standBtn.gameObject.SetActive(true);
        standBtnText.text = "Stand";
        // Set standard pot size
        pot = potConstValue + bets;
        betsText.text = "Bet: $" + (pot/2).ToString();
        playerScript.AdjustMoney(-(pot/2));
        //cashText.text = "Cash: $" + playerScript.GetMoney().ToString();
        // Update display ONLY on round end in RoundOver fun below
        deckSizeText.text = "Size: " + GameObject.Find("DeckCard").GetComponent<DeckScriptV2>().GetRemainingDeckSize()
                                                            .ToString("0.0", System.Globalization.CultureInfo.InvariantCulture); // double to 1 decimal
        cardCountText.text = "Count: " + GameObject.Find("DeckCard").GetComponent<DeckScriptV2>().GetCountCardTotal().ToString(); 

        //retry btn hide when playing games games
        retryBtn.gameObject.SetActive(false);


        // testing AI BS moves
        aiControllerScript.MakeMove(dealBtn, standBtn, hitBtn, betBtn, playerScript.handValue);
    }

    private void HitClicked() {
        // Check that there is still room on the table
        if (playerScript.cardIndex < 11)
        {
            playerScript.GetCard();
            playerHandText.text = "Hand: " + playerScript.handValue.ToString();
            if (playerScript.cardIndex == 11) hitBtn.gameObject.SetActive(false);
            if (playerScript.handValue > 20) RoundOver(); //after you bust dealer dont do his move



            else {
                //testing
                int handValue = playerScript.handValue;
                aiControllerScript.MakeMove(dealBtn, standBtn, hitBtn, betBtn, handValue);
            }
        } 
    }

    private void StandClicked() {
        standClicks++;
        if (standClicks > 1) RoundOver();
        HitDealer();
        standBtnText.text = "Call";
    }

    private void HitDealer() {
        int standDealerValue = 17; //stand soft 17
        while (dealerScript.handValue < standDealerValue && dealerScript.cardIndex < 11)
        {
            dealerScript.GetCard();
            dealerHandText.text = "Hand: " + dealerScript.handValue.ToString();
            if (dealerScript.handValue > 20) break; //RoundOver(); //?
        }
    }

    private void RoundOver() {
        // Booleans (true/false) for bust and blackjack/21
        bool playerBust = playerScript.handValue > 21;
        bool dealerBust = dealerScript.handValue > 21;
        bool player21 = playerScript.handValue == 21;
        bool dealer21 = dealerScript.handValue == 21;
        // If stand has been clicked less than twice, no 21s or busts, quit function
        if (standClicks < 2 && !playerBust && !dealerBust && !player21 && !dealer21) return;
        bool roundOver = true;
        // All bust, bets returned
        if (playerBust && dealerBust)
        {
            pushes++;
            mainText.text = "All Bust: Bets returned";
            playerScript.AdjustMoney(pot / 2);
            pot = potConstValue;
        }
        // if player busts, dealer didnt, or if dealer has more points, dealer wins
        else if (playerBust || (!dealerBust && dealerScript.handValue > playerScript.handValue))
        {
            looses++;
            mainText.text = "Dealer wins! :(";
            mainText.color = Color.red;
            pot = potConstValue;
        }
        // if dealer busts, player didnt, or player has more points, player wins
        else if (dealerBust || (!playerBust && playerScript.handValue > dealerScript.handValue))
        {
            wins++;
            mainText.text = "You win! ^^";
            mainText.color = Color.green;
            playerScript.AdjustMoney(pot);
            pot = potConstValue;
        }
        //Check for tie, return bets
        else if (playerScript.handValue == dealerScript.handValue)
        {
            pushes++;
            mainText.text = "Push: Bets returned";
            mainText.color = Color.white;
            playerScript.AdjustMoney(pot / 2);
            pot = potConstValue;
        }
        else
        {
            roundOver = false; //just in case
        }

        // Set ui up for next move / hand / turn
        if (roundOver)
        {
            games++;
            hitBtn.gameObject.SetActive(false);
            standBtn.gameObject.SetActive(false);
            dealBtn.gameObject.SetActive(true);
            betBtn.gameObject.SetActive(true);
            mainText.gameObject.SetActive(true);
            dealerHandText.gameObject.SetActive(true);
            hideCard.GetComponent<Renderer>().enabled = false;
            cashText.text = "$" + playerScript.GetMoney().ToString();
            standClicks = 0;
            pot = potConstValue;
            bets = 0;

            //bring decksize and cardcount back and display values at the end of a round
            deckSizeText.gameObject.SetActive(true);
            cardCountText.gameObject.SetActive(true);
            deckSizeText.text = "Size: " + GameObject.Find("DeckCard").GetComponent<DeckScriptV2>().GetRemainingDeckSize()
                                                    .ToString("0.0", System.Globalization.CultureInfo.InvariantCulture); // double to 1 decimal
            cardCountText.text = "Count: " + GameObject.Find("DeckCard").GetComponent<DeckScriptV2>().GetCountCardTotal().ToString(); 

            //Debug W/L/P
            Debug.Log("Games:"+games+"/W:"+wins+"/L:"+looses+"/P:"+pushes); 

            if (games >= maxGamesCount) { // when game limit reached
                dealBtn.gameObject.SetActive(false);
                if (playerScript.GetMoney() > 10000) retryBtn.gameObject.SetActive(true); // stop gaming when 10k reached from 100k to not go broke >,<
                mainText.text = "Max Game Count: "+maxGamesCount;
                games = 0; wins = 0; looses = 0; pushes = 0;
            }

            // Dealing again after round over if dealBtn enabled
            aiControllerScript.DealNewGame(dealBtn, standBtn, hitBtn);
        }
    }

    // Add money to pot if bet clicked
    private void BetClicked()
    {
        TMP_Text newBet = betBtn.GetComponentInChildren(typeof(TMP_Text)) as TMP_Text;
        string newBetText = newBet.text;
        int intBet = int.Parse(newBetText.Remove(0, 1));
        // playerScript.AdjustMoney(-intBet);
        // cashText.text = "$" + playerScript.GetMoney().ToString();
        bets += (intBet * 2);
        betsText.text = "Bets: $" + ((pot+bets)/2).ToString();
    }

    void Update() {
        if (Input.GetKeyDown(dealKey) && dealBtn.gameObject.activeSelf) {
            dealBtn.onClick.Invoke();
        }

        if (Input.GetKeyDown(hitKey) && hitBtn.gameObject.activeSelf) {
            hitBtn.onClick.Invoke();
        }

        if (Input.GetKeyDown(standKey) && standBtn.gameObject.activeSelf) {
            standBtn.onClick.Invoke();
        }

        if (Input.GetKeyDown(betKey) && betBtn.gameObject.activeSelf) {
            betBtn.onClick.Invoke();
        }

        if (Input.GetKeyDown(retryKey) && retryBtn.gameObject.activeSelf) {
            retryBtn.onClick.Invoke();
        }
    }
}
