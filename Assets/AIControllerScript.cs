using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Threading.Tasks;

public class AIControllerScript : MonoBehaviour
{
    void Start()  {} // Start is called before the first frame update
    void Update() {} // Update is called once per frame

    public PlayerScript playerScript;
    public PlayerScript dealerScript;

    int decisionCap = 2 * 10000; //for safety for now (allows for around [decisionCap/2] games) - 10 000?
    int decisionCount = 0;

    public void MakeMove(Button dealBtn, Button standBtn, Button hitBtn, Button betBtn, int handValue) {
        decisionCount++;
        if (decisionCount >= decisionCap) {Debug.Log("Decisions/AI moves limit reached"); return;}
        // testing: (works)
        int dealerCard1 = dealerScript.hand[0].GetComponent<CardScript>().GetValueOfCard();
        int dealerCard2 = dealerScript.hand[1].GetComponent<CardScript>().GetValueOfCard(); //not used for prediction - hidden card
        int playerCard1 = playerScript.hand[0].GetComponent<CardScript>().GetValueOfCard();
        int playerCard2 = playerScript.hand[1].GetComponent<CardScript>().GetValueOfCard();

        bool haveAce = false;
        if (playerCard1 == 11 || playerCard2 == 11) haveAce = true;
        //if ((playerCard1 == 1 && playerCard2 == 11) || (playerCard1 == 11 && playerCard2 == 1)) MakeMoveInside("S", dealBtn, standBtn, hitBtn, betBtn); // if dealt 2 Aces

        string move = playerScript.ReturnBSMove(haveAce, dealerCard1, playerCard1, playerCard2, handValue);

        MakeMoveInside(move, dealBtn, standBtn, hitBtn, betBtn);
        
    }

    public void MakeMoveInside(string move, Button dealBtn, Button standBtn, Button hitBtn, Button betBtn) {

        if (move == "S") { //stand
            standBtn.onClick.Invoke();
            //wait(100);
            standBtn.onClick.Invoke();
        } else if (move == "H") { //hit
            hitBtn.onClick.Invoke();
        } else if (move == "D") { //double
            // TODO not yet implemented
        } else {
            // do nothing
        }
    }

    public void DealNewGame(Button dealBtn, Button standBtn, Button hitBtn) {
        if (dealBtn.gameObject.activeSelf == true) {                                                    // to be sure I can click it
            if ((hitBtn.gameObject.activeSelf == false) && (standBtn.gameObject.activeSelf == false)) { // to be sure the round is over
                dealBtn.onClick.Invoke();
            }
        }
    }

    // HELPERS

    public async void wait(int milliseconds) { //use: wait(1000);
        var t = Task.Run(
            async delegate {
                await Task.Delay(milliseconds);
            }
        );
        t.Wait();
    }
}
