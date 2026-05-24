import jsonschema
from robot.api.deco import keyword


class SchemaValidator:

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

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

    @keyword("Validate Booking Response Schema")
    def validate_booking_response_schema(self, response_dict):
        jsonschema.validate(instance=response_dict, schema=self.BOOKING_SCHEMA)

    @keyword("Validate Room List Response Schema")
    def validate_room_list_response_schema(self, response_dict):
        jsonschema.validate(instance=response_dict, schema=self.ROOM_LIST_SCHEMA)
