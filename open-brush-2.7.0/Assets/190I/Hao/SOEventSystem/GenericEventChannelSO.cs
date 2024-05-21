using UnityEngine.Events;

public abstract class GenericEventChannelSO<T> : DescriptionSO
{
    public UnityAction<T> OnEventRaised;

    public void RaiseEvent(T parameter)
    {
        OnEventRaised?.Invoke(parameter);
    }
}




