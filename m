From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/4] Input: icn8318 - Add support for capacative home button
Date: Sun, 18 Jun 2017 12:18:29 +0200
Message-ID: <20170618101829.18734-4-hdegoede@redhat.com>
References: <20170618101829.18734-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdFRKSi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 06:18:38 -0400
In-Reply-To: <20170618101829.18734-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Some x86 tablets with an icn8505 touchscreen have a capacative home
button, add support for this.

Note that it turns out that the removed comment (and if) is inaccurate,
yes when the capacative home button is pressed the touch info contains
invalid data, but touch_count is set to 0 so this is not a problem and
if both the button is used and a finger is touching the normal
touchscreen area then there is valid touch data.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/chipone_icn8318.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 7a28caef1475..ab8f037fc9bc 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -125,16 +125,6 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (touch_data.softbutton) {
-		/*
-		 * Other data is invalid when a softbutton is pressed.
-		 * This needs some extra devicetree bindings to map the icn8318
-		 * softbutton codes to evdev codes. Currently no known devices
-		 * use this.
-		 */
-		return IRQ_HANDLED;
-	}
-
 	if (touch_data.touch_count > ICN8318_MAX_TOUCHES) {
 		dev_warn(dev, "Too much touches %d > %d\n",
 			 touch_data.touch_count, ICN8318_MAX_TOUCHES);
@@ -157,6 +147,7 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 	}
 
 	input_mt_sync_frame(data->input);
+	input_report_key(data->input, KEY_LEFTMETA, touch_data.softbutton == 1);
 	input_sync(data->input);
 
 	return IRQ_HANDLED;
@@ -329,6 +320,7 @@ static int icn8318_probe(struct i2c_client *client)
 				     le16_to_cpu(resolution[0]) - 1, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
 				     le16_to_cpu(resolution[1]) - 1, 0, 0);
+		input_set_capability(input, EV_KEY, KEY_LEFTMETA);
 	}
 
 	touchscreen_parse_properties(input, true, &data->prop);
-- 
2.13.0

