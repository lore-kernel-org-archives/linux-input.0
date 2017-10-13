From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4] Input: goodix - Poll the 'buffer status' bit before reading data
Date: Fri, 13 Oct 2017 21:40:25 +0200
Message-ID: <20171013194025.10077-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbdJMTka (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 15:40:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Bastien Nocera <hadess@hadess.net>, russianneuromancer@ya.ru

From: Paul Cercueil <paul@crapouillou.net>

The Goodix panel triggers an interrupt on touch events. However, its
registers will contain the valid values a short time after the
interrupt, and not when it's raised. At that moment, the 'buffer status'
bit is set.

Previously, if the 'buffer status' bit was not set when the registers
were read, the data was discarded and no input event was emitted,
causing "finger down" or "finger up" events to be missed sometimes.

This went unnoticed until v4.9, as the DesignWare I2C driver commonly
used with this driver had enough latency for that bug to never trigger
until commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only
if necessary").

Now, in the IRQ handler we will poll (with a timeout) the 'buffer status'
bit and process the data of the panel as soon as this bit gets set.

Note that the Goodix panel will send a few spurious interrupts after the
'finger up' event, in which the 'buffer status' bit will never be set.

Cc: Bastien Nocera <hadess@hadess.net>
Cc: russianneuromancer@ya.ru
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
[hdegoede@redhat.com: Change poll loop to use jiffies,
                      add comment about typical poll time]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Bastien Nocera <hadess@hadess.net>
---
Changes in v2 (hdegoede):
-Change poll loop to use jiffies
-Add comment about typical poll time

Changes in v3 (hdegoede):
-Improve commit message
-Use a const var for the timeout, rename timeout var to max_timeout

Changes in v4 (hdegoede):
-Use a #define GOODIX_BUFFER_STATUS_TIMEOUT instead of a const int
-Add Bastien's Reviewed-by
---
 drivers/input/touchscreen/goodix.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 32d2762448aa..9cfba6ae3a68 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -64,6 +64,8 @@ struct goodix_ts_data {
 #define GOODIX_CONFIG_911_LENGTH	186
 #define GOODIX_CONFIG_967_LENGTH	228
 
+#define GOODIX_BUFFER_STATUS_TIMEOUT	20
+
 /* Register defines */
 #define GOODIX_REG_COMMAND		0x8040
 #define GOODIX_CMD_SCREEN_OFF		0x05
@@ -195,18 +197,38 @@ static int goodix_get_cfg_len(u16 id)
 
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
+	unsigned long max_timeout;
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
+	max_timeout = jiffies + msecs_to_jiffies(GOODIX_BUFFER_STATUS_TIMEOUT);
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
+	} while (time_before(jiffies, max_timeout));
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
2.14.2

