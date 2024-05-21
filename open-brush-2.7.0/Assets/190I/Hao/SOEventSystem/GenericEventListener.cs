using UnityEngine;

public abstract class GenericEventListener<T> : MonoBehaviour
{
    [SerializeField] protected GenericEventChannelSO<T> eventChannel;

    private void OnEnable()
    {
        eventChannel.OnEventRaised += HandleEvent;
    }

    private void OnDisable()
    {
        eventChannel.OnEventRaised -= HandleEvent;
    }

    protected virtual void HandleEvent(T param)
    {
        Debug.Log($"event \"{eventChannel.description}\" with param {param} is received.");
    }
}

public class IntEventListener : GenericEventListener<int> { }
public class FloatEventListener : GenericEventListener<float> { }
public class TransformEventListener : GenericEventListener<Transform> { }
public class BoolEventListener : GenericEventListener<bool> { }
public class ScriptableObjectEventListener : GenericEventListener<ScriptableObject> { }
