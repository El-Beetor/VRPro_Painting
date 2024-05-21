using UnityEngine;

public abstract class GenericEventRaiser<T> : MonoBehaviour
{
    public GenericEventChannelSO<T> eventChannel;
    public T defaultParam;

    private void TriggerEvent()
    {
        eventChannel.RaiseEvent(defaultParam);
    }
    protected virtual void TriggerEvent(T param)
    {
        //Debug.Log($"event \"{eventChannel.description}\" with param {param} is triggered.");
        eventChannel.RaiseEvent(param);
    }
}

public class IntEventRaiser : GenericEventRaiser<int> { }
public class FLoatEventRaiser : GenericEventRaiser<float> { }
public class TransformEventRaiser : GenericEventRaiser<Transform> { }
public class BoolEventRaiser : GenericEventRaiser<bool> { }