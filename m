From: mathieu.poirier@linaro.org
Subject: [PATCH 1/2] Input: Add device tree bindings for input keys
Date: Thu, 27 Jun 2013 10:13:24 -0600
Message-ID: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:63497 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3F0QUH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jun 2013 12:20:07 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro2so1129640pbb.27
        for <linux-input@vger.kernel.org>; Thu, 27 Jun 2013 09:20:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: grant.likely@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, john.stultz@linaro.org, kernel-team@android.com, linux-input@vger.kernel.org

From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>

This adds a simple device tree binding for the specification of
key sequences.  Definition of the keys found in the sequence are
located in 'include/uapi/linux/input.h'.

A keyset can be applied to a single device or the system as a
whole, depending on the associated driver.  An extention is also
provided for the definition of multiple keysets.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../devicetree/bindings/input/input-keyset.txt     |   78 ++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/input-keyset.txt

diff --git a/Documentation/devicetree/bindings/input/input-keyset.txt b/Documentation/devicetree/bindings/input/input-keyset.txt
new file mode 100644
index 0000000..4f96299
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/input-keyset.txt
@@ -0,0 +1,78 @@
+Input: keyset
+
+A simple binding to represent a set of keys as described in
+include/uapi/linux/input.h.  This is targeted at devices that want
+to react to certain key combination being pressed or need to
+perform some configuration based on a set of input keys.
+
+It can also be used in a scenario where the system has a whole
+needs to respond to a specific sequence of keys.
+
+Required properties:
+ - linux,input-keyset: An array of 1-cell entries representing the
+   values associated with the KEY_xyz #defines found in input.h.
+
+Example1:
+Applicable to a specific device:
+
+        matrix-keypad {
+                compatible = "gpio-matrix-keypad";
+                debounce-delay-ms = <5>;
+                col-scan-delay-us = <2>;
+
+                row-gpios = <&gpio2 25 0
+                             &gpio2 26 0
+                             &gpio2 27 0>;
+
+                col-gpios = <&gpio2 21 0
+                             &gpio2 22 0
+                             &gpio2 23 0>;
+
+                linux,keymap = <0x00000002
+                                0x01000005
+                                0x02000008
+                                0x00010003
+                                0x01010006
+                                0x02010009
+                                0x00020004
+                                0x01020007
+                                0x0202000a>;
+
+                linux,keyset = <0x04
+                                0x05
+                                0x0a>;
+        };
+
+Example2:
+Used as a system-wide parameter:
+
+	sysrq {
+		linux,input-keyset = <0x01
+				      0x0A
+				      0x19>;
+		timout-ms = <3000>;
+	};
+
+Would represent KEY_1, KEY_9 and KEY_P.
+
+Example3:
+Binding used when multiple declarations are needed:
+
+acme_keysets {
+        keyset0 {
+                linux,input-keyset = <0x01
+                                      0x02
+                                      0x03>;
+        };
+        keyset1 {
+                linux,input-keyset = <0x04
+                                      0x05
+                                      0x06>;
+        };
+        keyset2 {
+                linux,input-keyset = <0x07
+                                      0x08
+                                      0x09>;
+        };
+
+};
-- 
1.7.9.5

