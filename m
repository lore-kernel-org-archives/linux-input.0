From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] Input: mpr121 - handle multiple bits change of status register
Date: Thu, 12 Jan 2017 02:42:27 +0900
Message-ID: <1484156549-26585-4-git-send-email-akinobu.mita@gmail.com>
References: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484156549-26585-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This driver reports input events on their interrupts which are triggered
by the sensor's status register changes.  But only single bit change is
reported in the interrupt handler.  So if there are multiple bits are
changed at almost the same time, other press or release events are ignored.

This fixes it by detecting all changed bits in the status register.

Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/mpr121_touchkey.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index a2c5305..c809f70 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -86,7 +86,8 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 	struct mpr121_touchkey *mpr121 = dev_id;
 	struct i2c_client *client = mpr121->client;
 	struct input_dev *input = mpr121->input_dev;
-	unsigned int key_num, key_val, pressed;
+	unsigned int bit_changed;
+	unsigned int key_num;
 	int reg;
 
 	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
@@ -104,18 +105,25 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 
 	reg &= TOUCH_STATUS_MASK;
 	/* use old press bit to figure out which bit changed */
-	key_num = ffs(reg ^ mpr121->statusbits) - 1;
-	pressed = reg & (1 << key_num);
+	bit_changed = reg ^ mpr121->statusbits;
 	mpr121->statusbits = reg;
+	for (key_num = 0; key_num < mpr121->keycount; key_num++) {
+		unsigned int key_val, pressed;
 
-	key_val = mpr121->keycodes[key_num];
+		if (!(bit_changed & (1 << key_num)))
+			continue;
 
-	input_event(input, EV_MSC, MSC_SCAN, key_num);
-	input_report_key(input, key_val, pressed);
-	input_sync(input);
+		pressed = reg & (1 << key_num);
+		key_val = mpr121->keycodes[key_num];
+
+		input_event(input, EV_MSC, MSC_SCAN, key_num);
+		input_report_key(input, key_val, pressed);
+
+		dev_dbg(&client->dev, "key %d %d %s\n", key_num, key_val,
+			pressed ? "pressed" : "released");
 
-	dev_dbg(&client->dev, "key %d %d %s\n", key_num, key_val,
-		pressed ? "pressed" : "released");
+	}
+	input_sync(input);
 
 out:
 	return IRQ_HANDLED;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
