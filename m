From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 4/5] Input: mpr121 - handle multiple bits change of status register
Date: Sun, 15 Jan 2017 22:15:43 +0900
Message-ID: <1484486144-27947-5-git-send-email-akinobu.mita@gmail.com>
References: <1484486144-27947-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484486144-27947-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
* Use for_each_set_bit() to search changed bit

 drivers/input/keyboard/mpr121_touchkey.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 2558c60..a0210ae 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -86,7 +86,8 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 	struct mpr121_touchkey *mpr121 = dev_id;
 	struct i2c_client *client = mpr121->client;
 	struct input_dev *input = mpr121->input_dev;
-	unsigned int key_num, key_val, pressed;
+	unsigned long bit_changed;
+	unsigned int key_num;
 	int reg;
 
 	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
@@ -104,18 +105,22 @@ static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
 
 	reg &= TOUCH_STATUS_MASK;
 	/* use old press bit to figure out which bit changed */
-	key_num = ffs(reg ^ mpr121->statusbits) - 1;
-	pressed = reg & (1 << key_num);
+	bit_changed = reg ^ mpr121->statusbits;
 	mpr121->statusbits = reg;
+	for_each_set_bit(key_num, &bit_changed, mpr121->keycount) {
+		unsigned int key_val, pressed;
 
-	key_val = mpr121->keycodes[key_num];
+		pressed = reg & (1 << key_num);
+		key_val = mpr121->keycodes[key_num];
 
-	input_event(input, EV_MSC, MSC_SCAN, key_num);
-	input_report_key(input, key_val, pressed);
-	input_sync(input);
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
