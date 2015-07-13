From: Gavin Li <gavinli@thegavinli.com>
Subject: [PATCH] atkbd: add basic debounce support
Date: Mon, 13 Jul 2015 00:36:12 -0700
Message-ID: <1436772972-26919-1-git-send-email-gavinli@thegavinli.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36418 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbGMHgU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 03:36:20 -0400
Received: by pdjr16 with SMTP id r16so58333612pdj.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 00:36:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Gavin Li <git@thegavinli.com>

From: Gavin Li <git@thegavinli.com>

For physically quirky or otherwise poor keyboards.
---
 drivers/input/keyboard/atkbd.c | 69 +++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 387c51f..b1ff62d 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -28,6 +28,7 @@
 #include <linux/libps2.h>
 #include <linux/mutex.h>
 #include <linux/dmi.h>
+#include <linux/timekeeping.h>
 
 #define DRIVER_DESC	"AT and PS/2 keyboard driver"
 
@@ -67,6 +68,10 @@ static bool atkbd_terminal;
 module_param_named(terminal, atkbd_terminal, bool, 0);
 MODULE_PARM_DESC(terminal, "Enable break codes on an IBM Terminal keyboard connected via AT/PS2");
 
+static int atkbd_debounce;
+module_param_named(debounce, atkbd_debounce, int, 0);
+MODULE_PARM_DESC(debounce, "Milliseconds to debounce successive keys");
+
 /*
  * Scancode to keycode tables. These are just the default setting, and
  * are loadable via a userland utility.
@@ -218,6 +223,7 @@ struct atkbd {
 	bool softraw;
 	bool scroll;
 	bool enabled;
+	ktime_t debounce_ktime;
 
 	/* Accessed only from interrupt */
 	unsigned char emul;
@@ -227,6 +233,9 @@ struct atkbd {
 	unsigned int last;
 	unsigned long time;
 	unsigned long err_count;
+	bool is_debouncing;
+	unsigned short last_debounce_code;
+	ktime_t last_debounce_expiration;
 
 	struct delayed_work event_work;
 	unsigned long event_jiffies;
@@ -375,7 +384,7 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 	struct atkbd *atkbd = serio_get_drvdata(serio);
 	struct input_dev *dev = atkbd->dev;
 	unsigned int code = data;
-	int scroll = 0, hscroll = 0, click = -1;
+	int scroll = 0, hscroll = 0, keypress = 0, click = -1;
 	int value;
 	unsigned short keycode;
 
@@ -456,23 +465,9 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 
 	keycode = atkbd->keycode[code];
 
-	if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)))
-		if (keycode != ATKBD_KEY_NULL)
-			input_event(dev, EV_MSC, MSC_SCAN, code);
-
 	switch (keycode) {
 	case ATKBD_KEY_NULL:
-		break;
 	case ATKBD_KEY_UNKNOWN:
-		dev_warn(&serio->dev,
-			 "Unknown key %s (%s set %d, code %#x on %s).\n",
-			 atkbd->release ? "released" : "pressed",
-			 atkbd->translated ? "translated" : "raw",
-			 atkbd->set, code, serio->phys);
-		dev_warn(&serio->dev,
-			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
-			 code & 0x80 ? "e0" : "", code & 0x7f);
-		input_sync(dev);
 		break;
 	case ATKBD_SCR_1:
 		scroll = 1;
@@ -496,6 +491,7 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 		hscroll = 1;
 		break;
 	default:
+		keypress = 1;
 		if (atkbd->release) {
 			value = 0;
 			atkbd->last = 0;
@@ -507,7 +503,49 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 			atkbd->last = code;
 			atkbd->time = jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]) / 2;
 		}
+	}
+
+	if (keypress) {
+		if (atkbd->is_debouncing && code == atkbd->last_debounce_code) {
+			/* ignore debounced release/repeat event */
+			if (value == 0) {
+				atkbd->is_debouncing = false;
+				atkbd->release = false;
+			}
+			goto out;
+		}
+		if (!atkbd->is_debouncing && value == 1) {
+			ktime_t now = ktime_get();
+			if (code == atkbd->last_debounce_code &&
+					ktime_before(now, atkbd->last_debounce_expiration)) {
+				/* debounce the press event */
+				dev_dbg(&serio->dev, "Debounced scan code %#x.\n", code);
+				atkbd->is_debouncing = !test_bit(code, atkbd->force_release_mask);
+				goto out;
+			} else {
+				atkbd->last_debounce_code = code;
+				atkbd->last_debounce_expiration = ktime_add(now, atkbd->debounce_ktime);
+			}
+		}
+	}
+
+	if (keycode != ATKBD_KEY_NULL)
+		if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)))
+			input_event(dev, EV_MSC, MSC_SCAN, code);
+
+	if (keycode == ATKBD_KEY_UNKNOWN) {
+		dev_warn(&serio->dev,
+			 "Unknown key %s (%s set %d, code %#x on %s).\n",
+			 atkbd->release ? "released" : "pressed",
+			 atkbd->translated ? "translated" : "raw",
+			 atkbd->set, code, serio->phys);
+		dev_warn(&serio->dev,
+			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
+			 code & 0x80 ? "e0" : "", code & 0x7f);
+		input_sync(dev);
+	}
 
+	if (keypress) {
 		input_event(dev, EV_KEY, keycode, value);
 		input_sync(dev);
 
@@ -1161,6 +1199,7 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 	atkbd->softraw = atkbd_softraw;
 	atkbd->softrepeat = atkbd_softrepeat;
 	atkbd->scroll = atkbd_scroll;
+	atkbd->debounce_ktime = ms_to_ktime(max(atkbd_debounce, 0));
 
 	if (atkbd->softrepeat)
 		atkbd->softraw = true;
-- 
2.4.5

