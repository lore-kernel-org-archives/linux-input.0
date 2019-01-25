From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 4/4] dt-bindings: input: Add documentation for gp2a sensor
Date: Fri, 25 Jan 2019 18:50:45 +0100
Message-ID: <20190125175045.22576-5-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mchehab+samsung@kernel.org, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca, pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

This commit adds documentation for Sharp GP2AP002A00F.
It's Proximity/Opto Sensor connected over i2c.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/input/sharp,gp2ap002a00f.txt     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt

diff --git a/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
new file mode 100644
index 000000000000..c524eb7d3d60
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
@@ -0,0 +1,29 @@
+* Sharp GP2AP002A00F I2C Proximity/Opto Sensor
+
+Required properties:
+- compatible : Should be "sharp,gp2ap002a00f"
+- reg : The I2C address of the sensor
+- vout-gpio : The gpio connected to the vout pin
+- interrupt-parent : should be the phandle for the interrupt controller
+- interrupts : Interrupt mapping for GPIO IRQ, it should by configured with
+		flags IRQ_TYPE_EDGE_BOTH
+
+Optional properties:
+- wakeup : If the device is capable of waking up the system
+- io-channels : Phandle to an ADC channel connected to the light sensor
+- io-channel-names = "light";
+- poll-interval : Poll interval time in milliseconds, default 500ms
+- light-adc-max : Maximum light value reported, default 4096
+- light-adc-fuzz : Fuzz value for reported light value, default 80
+
+Example:
+
+gp2a@44 {
+	compatible = "sharp,gp2ap002a00f";
+	reg = <0x44>;
+	vout-gpio = <&gph0 2 GPIO_ACTIVE_HIGH>;
+	interrupt-parent = <&gph0>;
+	interrupts = <2 IRQ_TYPE_EDGE_BOTH>;
+	io-channels = <&adc 9>;
+	io-channel-names = "light";
+};
-- 
2.17.1
