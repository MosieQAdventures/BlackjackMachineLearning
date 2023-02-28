using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CardScript : MonoBehaviour
{
    public int value = 0;
    public int countingValue = 0;

    public int GetValueOfCard()
    {
        return value;
    }

    public void SetValue(int newValue)
    {
        value = newValue;
    }

    public int GetCountingValue()
    {
        return countingValue;
    }

    public void SetCountingValue(int newValue)
    {
        countingValue = newValue;
    }

    public string GetSpriteName()
    {
        return GetComponent<SpriteRenderer>().sprite.name;
    }

    public void SetSprite(Sprite newSprite)
    {
        gameObject.GetComponent<SpriteRenderer>().sprite = newSprite;
    }

    public void ResetCard()
    {
        Sprite back = GameObject.Find("DeckCard").GetComponent<DeckScriptV2>().GetCardBack();
        gameObject.GetComponent<SpriteRenderer>().sprite = back;
        value = 0;
    }    
}
