from faker import Faker
import datetime
import random

fake = Faker()


def generate_booking_payload(roomid):
    checkin = datetime.date.today() + datetime.timedelta(days=random.randint(1, 30))
    checkout = checkin + datetime.timedelta(days=random.randint(1, 7))
    return {
        "roomid": int(roomid),
        "firstname": fake.first_name(),
        "lastname": fake.last_name(),
        "depositpaid": fake.boolean(),
        "bookingdates": {
            "checkin": checkin.strftime("%Y-%m-%d"),
            "checkout": checkout.strftime("%Y-%m-%d"),
        },
        "email": fake.email(),
        "phone": fake.numerify("07#########"),
    }


def generate_room_payload():
    return {
        "roomName": str(fake.random_int(min=100, max=999)),
        "type": random.choice(["Single", "Double", "Twin", "Family", "Suite"]),
        "accessible": fake.boolean(),
        "image": "https://www.mwtestconsultancy.co.uk/img/testim/room2.jpg",
        "description": fake.sentence(nb_words=10),
        "features": random.sample(["WiFi", "TV", "Radio", "Refreshments", "Safe", "Views"], k=2),
        "roomPrice": fake.random_int(min=50, max=300),
    }


def generate_invalid_booking_dates():
    checkin = datetime.date.today() + datetime.timedelta(days=5)
    checkout = checkin - datetime.timedelta(days=3)
    return {
        "checkin": checkin.strftime("%Y-%m-%d"),
        "checkout": checkout.strftime("%Y-%m-%d"),
    }
