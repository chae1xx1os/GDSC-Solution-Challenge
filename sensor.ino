#include <Wire.h>
#include <MPU6050.h>
#include <WiFi.h>

MPU6050 accelgyro;

const char *ssid = "123456789";
const char *password = "123456789";

WiFiServer server(80);

int16_t ax, ay, az;
int16_t gx, gy, gz;

const int historySize = 5;
int16_t pre_gx[historySize];
int16_t pre_gy[historySize];
int16_t pre_gz[historySize];
int historyIndex = 0;

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

    for (int i = 0; i < historySize; i++) {
        pre_gx[i] = 0;
        pre_gy[i] = 0;
        pre_gz[i] = 0;
    }
}

void loop() {
    WiFiClient client = server.available();
    if (client) {
        accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);

        int16_t diff_gx = gx - pre_gx[historyIndex];
        int16_t diff_gy = gy - pre_gy[historyIndex];
        int16_t diff_gz = gz - pre_gz[historyIndex];

        client.println("HTTP/1.1 200 OK");
        client.println("Content-Type: text/html");
        client.println("Connection: close");
        client.println();
        client.println("<html><body>");
        client.print("GX: ");
        client.print(diff_gx);
        client.print(", GY: ");
        client.print(diff_gy);
        client.print(", GZ: ");
        client.println(diff_gz);
        client.println("</body></html>");

        pre_gx[historyIndex] = gx;
        pre_gy[historyIndex] = gy;
        pre_gz[historyIndex] = gz;

        historyIndex = (historyIndex + 1) % historySize;

        Serial.print("GX: ");
        Serial.print(diff_gx);
        Serial.print(", GY: ");
        Serial.print(diff_gy);
        Serial.print(", GZ: ");
        Serial.println(diff_gz);

        delay(500);  // 보드 및 통신 과부화 방지 추후에 고치기 -> 최종적으로 끝나면
    }
}