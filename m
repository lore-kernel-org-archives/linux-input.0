From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] Input: Add binding document for a generic ADC keypad
Date: Fri, 27 Mar 2015 17:43:17 -0700
Message-ID: <1427503398-19682-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add a binding document for a generic ADC keypad.  Buttons on an ADC
keypad are connected in a resistor ladder to an ADC.  The binding
describes the mapping of ADC channel and voltage ranges to buttons.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/input/adc-keys.txt         | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
new file mode 100644
index 0000000..c9a57de
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-keys.txt
@@ -0,0 +1,43 @@
+Generic ADC keypad
+==================
+
+Required properties:
+ - compatible: "adc-keys"
+ - poll-interval: Polling interval time in ms.
+ - io-channels: List of IIO channels used by the keypad.
+   See ../iio/iio-bindings.txt for details.
+
+Optional properties:
+ - autorepeat: Enable auto-repeat.
+
+Each button on the ADC keypad is represented by a sub-node.
+
+Required sub-node properties:
+ - label: Descriptive name for the key.
+ - linux,code: Keycode to emit.
+ - channel: IIO channel (index into the 'io-channels' above) to which this
+   button is attached.
+ - min-voltage: Minimum voltage in uV when this key is pressed.
+ - max-voltage: Maximum voltage in uV when this key is pressed.
+
+Optional sub-node properties:
+ - linux,input-type: Event type this key generates.  Defaults to 1 (EV_KEY) if
+   not specified.
+
+Example:
+
+adc-keypad {
+	compatible = "adc-keys";
+	poll-interval = <100>;
+	io-channels = <&adc 0>, <&adc 1>;
+
+	vol-up-button {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		min-voltage = <1600000>;
+		max-voltage = <1640000>;
+	};
+
+	...
+};
-- 
2.2.0.rc0.207.ga3a616c
