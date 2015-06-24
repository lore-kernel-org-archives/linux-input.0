From: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 1/2] dt: add cap11xx LED documentation
Date: Tue, 23 Jun 2015 23:50:53 -0700
Message-ID: <1435128654-19454-2-git-send-email-mranostay@gmail.com>
References: <1435128654-19454-1-git-send-email-mranostay@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435128654-19454-1-git-send-email-mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
