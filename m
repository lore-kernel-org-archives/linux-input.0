From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Date: Fri, 25 Jan 2019 19:44:00 +0100
Message-ID: <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add device tree bindings for Bosch BMA150 Accelerometer Sensor

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/input/bosch,bma150.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt

diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
new file mode 100644
index 000000000000..290c60e38c70
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
@@ -0,0 +1,20 @@
+* Bosch BMA150 Accelerometer Sensor
+
+Also works for the SMB380 and BMA023 accelerometers
+
+Required properties:
+- compatible : Should be "bosch,bma150"
+- reg : The I2C address of the sensor
+
+Optional properties:
+- interrupt-parent : should be the phandle for the interrupt controller
+- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
+
+Example:
+
+bma150@38 {
+	compatible = "bosch,bma150";
+	reg = <0x38>;
+	interrupt-parent = <&gph0>;
+	interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1
