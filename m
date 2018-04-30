From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 4/9] dt-bindings: input: touchscreen: resistive-adc-touch: create bindings
Date: Mon, 30 Apr 2018 13:32:10 +0300
Message-ID: <1525084335-11276-5-git-send-email-eugen.hristev@microchip.com>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Added bindings for generic resistive touchscreen ADC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
 - renamed file and compatible to exclude "generic" keyword
 - removed the pressure threshold property, added it as a common
touchscreen property in the touchscreen common bindings in a separate
commit.

Changes in v2:
 - modified bindings to have a generic resistive touchscreen adc driver
instead of specific architecture one.

 .../input/touchscreen/resistive-adc-touch.txt      | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
new file mode 100644
index 0000000..1c4e4a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
@@ -0,0 +1,30 @@
+Generic resistive touchscreen ADC
+
+Required properties:
+
+ - compatible: must be "resistive-adc-touch"
+The device must be connected to an ADC device that provides channels for
+position measurement and optional pressure.
+Refer to ../iio/iio-bindings.txt for details
+ - iio-channels: must have at least two channels connected to an ADC device.
+These should correspond to the channels exposed by the ADC device and should
+have the right index as the ADC device registers them. These channels
+represent the relative position on the "x" and "y" axes.
+ - iio-channel-names: must have all the channels' names. Mandatory channels
+are "x" and "y".
+
+Optional properties:
+ - iio-channels: The third channel named "pressure" is optional and can be
+used if the ADC device also measures pressure besides position.
+If this channel is missing, pressure will be ignored and the touchscreen
+will only report position.
+ - iio-channel-names: optional channel named "pressure".
+
+Example:
+
+	resistive_touch: resistive_touch {
+		compatible = "resistive-adc-touch";
+		touchscreen-threshold-pressure = <50000>;
+		io-channels = <&adc 24>, <&adc 25>, <&adc 26>;
+		io-channel-names = "x", "y", "pressure";
+	};
-- 
2.7.4
