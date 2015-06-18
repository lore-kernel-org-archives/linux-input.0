From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 1/2] dt: add cap11xx LED documentation
Date: Wed, 17 Jun 2015 20:58:16 -0700
Message-ID: <1434599897-22505-2-git-send-email-mranostay@gmail.com>
References: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: zonque@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/input/cap11xx.txt          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt b/Documentation/devicetree/bindings/input/cap11xx.txt
index 7d0a300..09cdc43 100644
--- a/Documentation/devicetree/bindings/input/cap11xx.txt
+++ b/Documentation/devicetree/bindings/input/cap11xx.txt
@@ -38,6 +38,11 @@ Optional properties:
 				defaults. The array must have exactly six
 				entries.
 
+	linux,led-brightness:	Defines the ON brightness when the optional LED
+				functionality is used. Valid values are 1-15.
+				By default a value of 15 is set.
+
+
 Example:
 
 i2c_controller {
@@ -55,5 +60,25 @@ i2c_controller {
 				 <105>,		/* KEY_LEFT */
 				 <109>,		/* KEY_PAGEDOWN */
 				 <104>;		/* KEY_PAGEUP */
+
+		linux,led-brightness = <15>;
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
