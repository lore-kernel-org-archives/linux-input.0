From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 1/2] input: adc-keys: add DT binding documentation
Date: Sat,  9 Jul 2016 03:24:01 +0200
Message-ID: <1468027442-5033-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add documentation for ADC keys

Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Changes in v2:
 - fix title
 - use keyup-threshold-mvolt and press-threshold-mvolt instead of
   voltage-keyup-mvolt and voltage-mvolt.

 .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
new file mode 100644
index 000000000000..e43b8979b85a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-keys.txt
@@ -0,0 +1,45 @@
+ADC attached resistor ladder buttons
+------------------------------------
+
+Required properties:
+ - compatible: "adc-keys"
+ - io-channels: Phandle to an ADC channel
+ - io-channel-names = "buttons";
+ - keyup-threshold-mvolt: Voltage at which all the keys are considered up.
+
+Each key is represented as a sub-node of "adc-keys":
+
+Required subnode-properties:
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+	- press-threshold-mvolt: Voltage adc input when this key is pressed.
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&lradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-mvolt = <2000>;
+
+		button@1500 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-mvolt = <1500>;
+		};
+
+		button@1000 {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-mvolt = <1000>;
+		};
+
+		button@500 {
+			label = "Enter";
+			linux,code = <KEY_ENTER>;
+			press-threshold-mvolt = <500>;
+		};
+	};
+
-- 
2.8.1
