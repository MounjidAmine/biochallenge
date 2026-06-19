export default function OrderingQuestion({ question, value = {}, onChange }) {
  const order = value.order || [];

  function toggle(itemId) {
    if (order.includes(itemId)) {
      onChange({ order: order.filter((id) => id !== itemId) });
      return;
    }

    onChange({ order: [...order, itemId] });
  }

  return (
    <div className="ordering-list">
      {question.items.map((item) => (
        <button
          className={order.includes(item.id) ? 'order-item selected' : 'order-item'}
          key={item.id}
          type="button"
          onClick={() => toggle(item.id)}
        >
          <span>{order.includes(item.id) ? order.indexOf(item.id) + 1 : ''}</span>
          {item.label}
        </button>
      ))}
    </div>
  );
}
