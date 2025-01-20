from motor.motor_asyncio import AsyncIOMotorClient
from datetime import datetime
from bson.objectid import ObjectId


# MongoDB connection URI
MONGODB_URI = "mongodb://localhost:27017/"
DATABASE_NAME = "payment_app"
COLLECTION_NAME = "transactions"

class MongoDB:
    def __init__(self):
        self.client = None
        self.db = None
        self.collection = None

    async def connect(self):
        """Initialize the MongoDB connection."""
        self.client = AsyncIOMotorClient(MONGODB_URI)
        self.db = self.client[DATABASE_NAME]
        self.collection = self.db[COLLECTION_NAME]

    async def close(self):
        """Close the MongoDB connection."""
        self.client.close()

    async def log_transaction(self, order_number: str, pay_amount: float, status: str):
        """Insert a transaction and return its ID."""
        result = await self.collection.insert_one({
            "order_number": order_number,
            "amount": pay_amount,
            "status": status,
            "created_at": datetime.utcnow()
        })
        return str(result.inserted_id)

    async def update_transaction_status(self, transaction_id: str, status: str):
        """Update the status of a transaction."""
        await self.collection.update_one(
            {"_id": ObjectId(transaction_id)},
            {"$set": {"status": status}}
        )
