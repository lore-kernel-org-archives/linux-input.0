From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH RESEND 1/2] dt: add cap11xx LED documentation
Date: Tue,  4 Aug 2015 21:24:55 -0700
Message-ID: <1438748696-28452-2-git-send-email-mranostay@gmail.com>
References: <1438748696-28452-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35590 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbHEEXi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2015 00:23:38 -0400
In-Reply-To: <1438748696-28452-1-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/input/cap11xx.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
index 7d0a300..8c67a0b 100644
--- a/Documentation/devicetree/bindings/input/cap11xx.txt
+++ b/Documentation/devicetree/bindings/input/cap11xx.txt
@@ -55,5 +55,24 @@ i2c_controller {
 				 <105>,		/* KEY_LEFT */
 				 <109>,		/* KEY_PAGEDOWN */
 				 <104>;		/* KEY_PAGEUP */
+
+		#address-cells = <1>;
+		#size-cells = <0>;
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

