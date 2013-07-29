From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH 4/5] atkbd: add support for handling KEY_FNLOCK
Date: Mon, 29 Jul 2013 00:59:38 -0300
Message-ID: <1375070379-329-4-git-send-email-m.chehab@samsung.com>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56915 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab3G2D7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 23:59:46 -0400
In-Reply-To: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>

Samsung keyboards have a key called FN LOCK. This key acts like
CAPS LOCK and NUM LOCK. When pressed, the keyboard switches to a state
where the produced scancode are the blue ones (the Fn keycodes).

Add support for it at atkbd.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 drivers/input/keyboard/atkbd.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 298ac1d..7f88132 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -218,6 +218,7 @@ struct atkbd {
 	bool softraw;
 	bool scroll;
 	bool enabled;
+	bool fnlock_set;
 
 	/* Accessed only from interrupt */
 	unsigned char emul;
@@ -453,6 +454,28 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 	if (keycode != ATKBD_KEY_NULL)
 		input_event(dev, EV_MSC, MSC_SCAN, code);
 
+	/*
+	 * Handles special Fn Lock switch.
+	 *
+	 * This switch can't be merged with the next one, as we also want
+	 * to report those keycodes to userspace, via input_event, and
+	 * call input_sync().
+	 */
+	switch (keycode) {
+	case KEY_FNLOCK_OFF:
+		atkbd->fnlock_set = false;
+		input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
+		break;
+	case KEY_FNLOCK_ON:
+		atkbd->fnlock_set = true;
+		input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
+		break;
+	case KEY_FNLOCK_TOGGLE:
+		atkbd->fnlock_set = !atkbd->fnlock_set;
+		input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
+		break;
+	}
+
 	switch (keycode) {
 	case ATKBD_KEY_NULL:
 		break;
@@ -1126,6 +1149,10 @@ static void atkbd_set_device_attrs(struct atkbd *atkbd)
 			__set_bit(atkbd->keycode[i], input_dev->keybit);
 		}
 	}
+
+	/* FIXME: Unconditionqally sets FN LOCK switch */
+	__set_bit(SW_FNLOCK, atkbd->dev->swbit);
+	input_dev->evbit[0] |= BIT_MASK(EV_SW);
 }
 
 /*
-- 
1.8.3.1

