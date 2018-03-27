From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 03/10] dt-bindings: input: touchscreen: touch_adc: create
 bindings
Date: Tue, 27 Mar 2018 15:32:36 +0300
Message-ID: <1522153963-1121-4-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Added bindings for generic resistive touchscreen ADC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
 - modified bindings to have a generic resistive touchscreen adc driver
instead of specific architecture one.

 .../bindings/input/touchscreen/touch_adc.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt b/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
new file mode 100644
index 0000000..27abcdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
@@ -0,0 +1,33 @@
+Generic resistive touchscreen ADC
+
+Required properties:
+
+ - compatible: must be "generic-resistive-adc-touch"
+The device must be connected to an IIO device that provides channels for
+position measurement and optional pressure.
+Refer to ../iio/iio-bindings.txt for details
+ - iio-channels: must have at least two channels connected to an IIO device.
+These should correspond to the channels exposed by the IIO device and should
+have the right index as the IIO device registers them. These channels
+represent the relative position on the "x" and "y" axes.
+ - iio-channel-names: must have all the channels' names. Mandatory channels
+are "x" and "y".
+
+Optional properties:
+ - iio-channels: The third channel named "pressure" is optional and can be
+used if the IIO device also measures pressure besides position.
+If this channel is missing, pressure will be ignored and the touchscreen
+will only report position.
+ - iio-channel-names: optional channel named "pressure".
+ - generic-resistive-adc-touch,pressure-threshold: a pressure threshold for
+the touchscreen, if we are using the "pressure" channel as well.
+Represented by an integer value.
+
+Example:
+
+	resistive_touch: resistive_touch {
+		compatible = "generic-resistive-adc-touch";
+		generic-resistive-adc-touch,pressure-threshold = <10000>;
+		io-channels = <&adc 24>, <&adc 25>, <&adc 26>;
+		io-channel-names = "x", "y", "pressure";
+	};
-- 
2.7.4
