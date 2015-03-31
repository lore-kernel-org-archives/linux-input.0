From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH V2 2/3] Input: Add binding document for ADC keypad
Date: Mon, 30 Mar 2015 17:28:08 -0700
Message-ID: <1427761689-5238-2-git-send-email-abrestic@chromium.org>
References: <1427761689-5238-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f73.google.com ([209.85.220.73]:34071 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbCaA2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Mar 2015 20:28:13 -0400
Received: by pabli10 with SMTP id li10so551472pab.1
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2015 17:28:13 -0700 (PDT)
In-Reply-To: <1427761689-5238-1-git-send-email-abrestic@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Add a binding document for a generic ADC keypad.  Buttons on an ADC
keypad are connected in a resistor ladder to an ADC.  The binding
describes the mapping of ADC channel and voltage ranges to buttons.
Note that this binding only describes simple ADC keypads where only
a single button press can be detected at once per ADC channel.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
Changes from v1:
 - Made linux,input-type a required property.
---
 .../devicetree/bindings/input/adc-keys.txt         | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
new file mode 100644
index 0000000..e531f25
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-keys.txt
@@ -0,0 +1,41 @@
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
+ - linux,input-type: Event type this key generates.
+ - channel: IIO channel (index into the 'io-channels' above) to which this
+   button is attached.
+ - min-voltage: Minimum voltage in uV when this key is pressed.
+ - max-voltage: Maximum voltage in uV when this key is pressed.
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
+		linux,input-type = <EV_KEY>;
+		channel = <0>;
+		min-voltage = <1600000>;
+		max-voltage = <1640000>;
+	};
+
+	...
+};
-- 
2.2.0.rc0.207.ga3a616c

