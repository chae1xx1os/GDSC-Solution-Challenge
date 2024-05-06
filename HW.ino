#include <Wire.h>
#include <MPU6050.h>
#include <WiFi.h>
#include <I2Cdev.h>

MPU6050 accelgyro;

const char *ssid = "123456789";
const char *password = "123456789";

WiFiServer server(80);

int16_t ax, ay, az;
int16_t gx, gy, gz;

bool data_output_active = false;
unsigned long last_button_press_time = 0;
int stand = 0;
int lie = 0;

#define OUTPUT_READABLE_ACCELGYRO

void setup() {
    Serial.begin(115200);
    Wire.begin();
    delay(1000);

    // Connect to Wi-Fi
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }
    Serial.println("WiFi connected.");
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());

    server.begin();
    accelgyro.initialize();

    if (accelgyro.testConnection()) {
        Serial.println("MPU6050 connection successful.");
    } else {
        Serial.println("MPU6050 connection failed.");
    }
}

void loop() {
    int num;

    unsigned long start_time = millis();
    bool continue_output = true;

        WiFiClient client = server.available();
        if (client) {
            accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
           
            if (ax >= -17000 && ax <= -13000 && ay >= -2000 && ay <= 2000) {
              num = 0; //Stick P1, LEFT
              num = 1; //Stick P2, LEFT
              num = 2; //Stick P1, RIGHT
              num = 3; //Stick P2, RIGHT
            }
            else
            {
              num = 4;
            }

            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: text/html");
            client.println("Connection: close");
            client.println();
            client.println("<html><body>");
            client.print("NUM: ");
            client.println(num);
            client.println("</body></html>");

            Serial.print("NUM: ");
            Serial.println(num);
            Serial.println(ax);
            Serial.println(ay);

            delay(500);
    }
}