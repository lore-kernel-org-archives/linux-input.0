From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 1/2] dt: add cap11xx LED documentation
Date: Fri, 12 Jun 2015 21:17:33 -0700
Message-ID: <1434169054-11035-2-git-send-email-mranostay@gmail.com>
References: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33956 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbFMEQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jun 2015 00:16:39 -0400
In-Reply-To: <1434169054-11035-1-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: zonque@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Some cap11xx devices have LEDs that can be controlled from userpace
and via triggers. Document their use and functionality here.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/input/cap11xx.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
index 7d0a300..ef89c27 100644
--- a/Documentation/devicetree/bindings/input/cap11xx.txt
+++ b/Documentation/devicetree/bindings/input/cap11xx.txt
@@ -38,6 +38,11 @@ Optional properties:
 				defaults. The array must have exactly six
 				entries.
 
+	linux,led-brightness:	Defines the ON brightness when the optional LED
+				functionality is used. Valid values are 0-15.
+				By default a value of 15 is set.
+
+
 Example:
 
 i2c_controller {
@@ -55,5 +60,23 @@ i2c_controller {
 				 <105>,		/* KEY_LEFT */
 				 <109>,		/* KEY_PAGEDOWN */
 				 <104>;		/* KEY_PAGEUP */
+
+		linux,led-brightness = <15>;
+
+		usr@0 {
+			label = "cap11xx:green:usr0";
+			reg = <0>;
+		};
+
+		usr@1 {
+			label = "cap11xx:green:usr1";
+			reg = <1>;
+		};
+
+		alive@2 {
+			label = "cap11xx:green:alive";
+			reg = <2>;
+			linux,default_trigger = "heartbeat";
+		};
 	};
 }
-- 
1.9.1

