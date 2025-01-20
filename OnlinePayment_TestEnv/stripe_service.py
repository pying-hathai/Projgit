import stripe

# Set your Stripe secret key
stripe.api_key = "..........."

async def process_payment(order_number: str, pay_amount: float, token: str):
    """Process a payment using Stripe."""
    try:
        charge = stripe.Charge.create(
            amount=int(pay_amount * 100),
            currency="usd",
            source=token,  # Use token from frontend
            description=f"Payment for Order {order_number}"
        )
        return charge
    except stripe.error.CardError as e:
        # Card was declined
        raise RuntimeError(f"Card declined: {e.user_message}")
    except stripe.error.StripeError as e:
        # Generic Stripe error
        raise RuntimeError(f"Stripe error: {str(e)}")
