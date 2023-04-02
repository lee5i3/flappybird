using UnityEngine;

public class Player : MonoBehaviour
{
    private SpriteRenderer spriteRenderer;

    private Vector3 direction;
    public Sprite[] sprites;
    private int spriteIndex;

    public float gravity = -9.8f;

    public float strength = 5f;

    [SerializeField] public AudioSource flySound;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space) || Input.GetMouseButtonDown(0))
        {
            direction = Vector3.up * strength;

            flySound.Play();
        }

        direction.y += gravity * Time.deltaTime;
        transform.position += direction * Time.deltaTime;
    }

    private void Start()
    {
        InvokeRepeating(nameof(AnimateSprite), 0.15f, 0.15f);
    }    

    private void Awake()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    private void AnimateSprite()
    {
        spriteIndex++;
        if (spriteIndex >= sprites.Length)
        {
            spriteIndex = 0;
        }

        spriteRenderer.sprite = sprites[spriteIndex];
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.gameObject.tag == "Obstacle")
        {
            FindObjectOfType<GameManager>().GameOver();
        } else
        {
            FindObjectOfType<GameManager>().IncreaseScore();
        }
    }

    private void OnEnable()
    {
        Vector3 position = transform.position;

        position.y = 0f;
        transform.position = position;
        direction = Vector3.zero;
    }
}
