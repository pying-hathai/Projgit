from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from db import MongoDB
from stripe_service import process_payment
from bson.objectid import ObjectId
from datetime import datetime
from datetime import datetime

app = FastAPI()

# Initialize MongoDB instance
db = MongoDB()

@app.on_event("startup")
async def startup():
    await db.connect()

@app.on_event("shutdown")
async def shutdown():
    await db.close()

class PaymentRequest(BaseModel):
    orderNumber: str = Field(..., example="12345")
    token: str = Field(..., example="tok_visa")  # Token from frontend
    payAmount: float = Field(..., gt=0, example=100.0)


@app.post("/process_payment")
async def process_payment_endpoint(request: PaymentRequest):
    order_number = request.orderNumber
    token = request.token
    pay_amount = request.payAmount

    try:
        transaction_id = await db.log_transaction(order_number, pay_amount, "Pending")

        try:
            charge = await process_payment(order_number, pay_amount, token)

            await db.update_transaction_status(transaction_id, "Success")

            return {
                "status": "success",
                "transactionId": charge.id,
                "message": "Payment processed successfully"
            }
        except RuntimeError as e:
            await db.update_transaction_status(transaction_id, "Failed")
            raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Unexpected error: {str(e)}")


# Health check endpoint
@app.get("/")
def health_check():
    return {"status": "ok"}
