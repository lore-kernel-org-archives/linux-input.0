From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] input: goodix: Poll the 'buffer status' bit before reading data
Date: Fri, 22 Sep 2017 20:51:26 +0200
Message-ID: <20170922185126.11262-2-hdegoede@redhat.com>
References: <20170922185126.11262-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbdIVSvf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 14:51:35 -0400
In-Reply-To: <20170922185126.11262-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Bastien Nocera <hadess@hadess.net>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-input@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

The Goodix panel triggers an interrupt on touch events. However, its
registers will contain the valid values a short time after the
interrupt, and not when it's raised. At that moment, the 'buffer status'
bit is set.

Previously, if the 'buffer status' bit was not set when the registers
were read, the data was discarded and no input event was emitted,
causing "finger down" or "finger up" events to be missed sometimes.

This went unnoticed until v4.9, as the DesignWare I2C driver commonly
used with this driver had enough latency for that bug to never trigger.

Now, in the IRQ handler we will poll (with a timeout) the 'buffer status'
bit and process the data of the panel as soon as this bit gets set.

Note that the Goodix panel will send a few spurious interrupts after the
'finger up' event, in which the 'buffer status' bit will never be set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
[hdegoede@redhat.com: Change poll loop to use jiffies,
                      add comment about typical poll time]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/goodix.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 32d2762448aa..a2071c132a2b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -195,18 +195,38 @@ static int goodix_get_cfg_len(u16 id)
 
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
+	unsigned long timeout;
 	int touch_num;
 	int error;
 
-	error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data,
-				GOODIX_CONTACT_SIZE + 1);
-	if (error) {
-		dev_err(&ts->client->dev, "I2C transfer error: %d\n", error);
-		return error;
-	}
+	/*
+	 * The 'buffer status' bit, which indicates that the data is valid, is
+	 * not set as soon as the interrupt is raised, but slightly after.
+	 * This takes around 10 ms to happen, so we poll for 20 ms.
+	 */
+	timeout = jiffies + msecs_to_jiffies(20);
+	do {
+		error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR,
+					data, GOODIX_CONTACT_SIZE + 1);
+		if (error) {
+			dev_err(&ts->client->dev, "I2C transfer error: %d\n",
+					error);
+			return error;
+		}
 
-	if (!(data[0] & 0x80))
-		return -EAGAIN;
+		if (data[0] & 0x80)
+			break;
+
+		usleep_range(1000, 2000); /* Poll every 1 - 2 ms */
+	} while (time_before(jiffies, timeout));
+
+	if (!(data[0] & 0x80)) {
+		/*
+		 * The Goodix panel will send spurious interrupts after a
+		 * 'finger up' event, which will always cause a timeout.
+		 */
+		return 0;
+	}
 
 	touch_num = data[0] & 0x0f;
 	if (touch_num > ts->max_touch_num)
-- 
2.14.1

