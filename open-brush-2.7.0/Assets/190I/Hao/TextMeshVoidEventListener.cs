using System.Collections;
using TMPro;
using UnityEngine;
public class TextMeshVoidEventListener : VoidEventListener
{
    protected override void HandleEvent()
    {
        base.HandleEvent();
        StartCoroutine(Change());
    }

    IEnumerator Change()
    {
        GetComponent<TextMeshPro>().color = Color.yellow;
        yield return new WaitForSeconds(2f);
        GetComponent<TextMeshPro>().color = Color.white;
    }
}
