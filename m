From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] Input: tc3589x-keypad - change name of wakeup property
Date: Fri, 17 Jul 2015 17:36:21 -0700
Message-ID: <1437179781-21124-7-git-send-email-dmitry.torokhov@gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437179781-21124-1-git-send-email-dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Wakeup property of device is not Linux-specific, it describes intended
system behavior regardless of the OS being used. Therefore let's drop
"linux," prefix, and, while at it, use the same name as I2C bus does:
"wakeup-source".

We keep parsing old name to keep compatibility with old DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/tc3589x.txt | 4 ++--
 drivers/input/keyboard/tc3589x-keypad.c           | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tc3589x.txt b/Documentation/devicetree/bindings/mfd/tc3589x.txt
index 6fcedba..37bf7f1 100644
--- a/Documentation/devicetree/bindings/mfd/tc3589x.txt
+++ b/Documentation/devicetree/bindings/mfd/tc3589x.txt
@@ -55,7 +55,7 @@ Optional nodes:
  - linux,keymap: the definition can be found in
    bindings/input/matrix-keymap.txt
  - linux,no-autorepeat: do no enable autorepeat feature.
- - linux,wakeup: use any event on keypad as wakeup event.
+ - wakeup-source: use any event on keypad as wakeup event.
 
 Example:
 
@@ -84,7 +84,6 @@ tc35893@44 {
 		keypad,num-columns = <8>;
 		keypad,num-rows = <8>;
 		linux,no-autorepeat;
-		linux,wakeup;
 		linux,keymap = <0x0301006b
 				0x04010066
 				0x06040072
@@ -103,5 +102,6 @@ tc35893@44 {
 				0x01030039
 				0x07060069
 				0x050500d9>;
+		wakeup-source;
 	};
 };
diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 31c606a..565805e 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -352,7 +352,10 @@ tc3589x_keypad_of_probe(struct device *dev)
 	}
 
 	plat->no_autorepeat = of_property_read_bool(np, "linux,no-autorepeat");
-	plat->enable_wakeup = of_property_read_bool(np, "linux,wakeup");
+
+	plat->enable_wakeup = of_property_read_bool(np, "wakeup-source") ||
+			      /* legacy name */
+			      of_property_read_bool(np, "linux,wakeup");
 
 	/* The custom delay format is ms/16 */
 	of_property_read_u32(np, "debounce-delay-ms", &debounce_ms);
-- 
2.4.3.573.g4eafbef

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
