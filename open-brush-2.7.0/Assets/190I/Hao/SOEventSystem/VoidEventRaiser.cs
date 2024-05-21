using UnityEngine;

public class VoidEventRaiser : MonoBehaviour
{
    [SerializeField] private VoidEventChannelSO eventChannel;

    public virtual void TriggerEvent()
    {
        Debug.Log($"void event {eventChannel.description} is triggered.");
        eventChannel.RaiseEvent();
    }
}
