import jsonschema

BOOKING_SCHEMA = {
    "type": "object",
    "required": ["bookingid", "booking"],
    "properties": {
        "bookingid": {"type": "integer"},
        "booking": {
            "type": "object",
            "required": ["firstname", "lastname", "depositpaid", "bookingdates"],
            "properties": {
                "firstname": {"type": "string"},
                "lastname": {"type": "string"},
                "depositpaid": {"type": "boolean"},
                "bookingdates": {
                    "type": "object",
                    "required": ["checkin", "checkout"],
                },
            },
        },
    },
}

ROOM_LIST_SCHEMA = {
    "type": "object",
    "required": ["rooms"],
    "properties": {
        "rooms": {
            "type": "array",
            "items": {
                "type": "object",
                "required": ["roomid", "roomName", "type", "roomPrice"],
            },
        }
    },
}


def validate_booking_response_schema(response_dict):
    jsonschema.validate(instance=response_dict, schema=BOOKING_SCHEMA)


def validate_room_list_response_schema(response_dict):
    jsonschema.validate(instance=response_dict, schema=ROOM_LIST_SCHEMA)
