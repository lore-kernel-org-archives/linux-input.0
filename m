From: Wang Yafei <wangyafei@goodix.com>
Subject: [PATCH] dt-bindings: input: Add the Goodix GTx5 series Touchscreen
 devicetree bindings
Date: Mon, 19 Jun 2017 18:40:32 +0800
Message-ID: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Mailgw01.goodix.com ([58.250.26.195]:2216 "EHLO
        barracuda.goodix.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753368AbdFSKkj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 06:40:39 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

Signed-off-by: Wang Yafei <wangyafei@goodix.com>
---
 .../bindings/input/touchscreen/goodix-gtx5.txt     | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
new file mode 100755
index 0000000..116c3ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
@@ -0,0 +1,75 @@
+Device tree bindings for Goodix GTx5 series touchscreen controller
+
+Required properties:
+
+- compatible	: should be "goodix,gtx5" or "goodix,gsx" 
+
+- reg	: I2C address of the chip. Should be 0x5d or 0x14
+- interrupt-parent	: Inerrupt controller to which the chip is connected
+- interrupts	: Interrrupt to which the chip is connected
+- touchscreen-size-x	: horizontal resolution of touchscreen          
+                                  (in pixels)                                   
+- touchscreen-size-y	: vertical resolution of touchscreen            
+                                  (in pixels)                                  
+- touchscreen-max-id	: panel supported max touch number.
+- touchscreen-max-w	: panel max width value.
+
+
+Optional properties:
+- reset-gpios	: reset gpio.
+- irq-gpios	: interrupt gpio. 
+- irq-flags	: irq trigger type config, value should be:
+                       1 - rising edge,
+                       2 - falling edge,
+                       4 - high level,
+                       5 - low level.
+- touchscreen-swapped-x-y: swap  x/y axis coordinates.
+- touchscreen-key-map: keycode value map  /*KEY_HOMEPAGE, KEY_BACK*/
+- power-on-delay-us: delay after power on.
+- power-off-delay-us: delay after power off.
+- normal-cfg: touch device normal config data.
+- vtouch-supply	: power supply for the touch device.
+Example:
+i2c@00000000 {
+	/* ... */
+
+	goodix-ts-i2c@14 {
+		compatible = "goodix,gtx5";
+		reg = <0x14>;
+		interrupt-parent = <&msm_gpio>;
+		interrupts = <13 0x2800>;
+		vtouch-supply = <&pm8916_l15>;
+		reset-gpios = <&msm_gpio 12 0x0>;
+		irq-gpios = <&msm_gpio 13 0x2800>;
+		irq-flags = <1>; /* 1:trigger rising, 2:trigger falling;*/
+		touchscreen-max-id = <10>;
+		touchscreen-size-x = <400>;
+		touchscreen-size-y = <400>;
+		touchscreen-max-w = <400>;
+		touchscreen-max-pressure = <255>;
+		touchscreen-swapped-x-y;
+		touchscreen-key-map = <172 158>; /*KEY_HOMEPAGE, KEY_BACK*/
+		sensor0 {
+			normal-cfg = [
+				02 00 00 09 09 01 07 02 00 00 00 00 01 00 3C 00 07 07
+				00 00 00 00 00 00 40 01 40 01 C8 00 96 00 F4 01 F4 01
+				F4 01 20 01 11 0A 0A 03 14 14 14 14 0A 0C 01 01 11 11
+				11 00 14 14 14 14 14 14 14 14 14 00 00 0F 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 11 09 10 00 31 32 33 34
+				00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 CA 64 00
+				00 00 00 00 00 00 09 00 13 00 00 00 00 00 00 00 00 00
+				50 B0 19 00 19 00 05 00 00 00 00 0A 05 00 00 00 00 00
+				01 00 FF 00 0B 06 0D 02 FF 04 05 03 07 01 08 0A 0E 11
+				0F 10 09 13 0C 16 17 14 18 12 19 15 1D 1E 1C 1F 1B 20
+				1A 2A 29 28 25 2B 27 21 FF 24 22 2C 26 23 FF 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 80 80 80 80 80 80
+				80 80 80 80 80 80 80 80 80 80 9F 22 01 AE];
+		};
+		sensor1 {
+			normal-cfg = [ ];
+		};
+	};
+}
+
+
-- 
2.7.4

