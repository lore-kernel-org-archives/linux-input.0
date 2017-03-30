From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] input: goodix: Poll the 'buffer status' bit before reading data
Date: Thu, 30 Mar 2017 15:33:49 +0200
Message-ID: <20170330133349.19931-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:60320
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933062AbdC3Nex (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 09:34:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>

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
---
 drivers/input/touchscreen/goodix.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 240b16f3ee97..7a8b89b87c2f 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -195,18 +195,34 @@ static int goodix_get_cfg_len(u16 id)
 
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
+	unsigned int timeout = 100;
 	int touch_num;
 	int error;
 
-	error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data,
+	/* The 'buffer status' bit, which indicates that the data is valid, is
+	 * not set as soon as the interrupt is raised, but slightly after.
+	 */
+	do {
+		error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, data,
 				GOODIX_CONTACT_SIZE + 1);
-	if (error) {
-		dev_err(&ts->client->dev, "I2C transfer error: %d\n", error);
-		return error;
-	}
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
+		usleep_range(100, 200);
+	} while (--timeout);
+
+	if (!timeout) {
+		/* The Goodix panel will send spurious interrupts after a
+		 * 'finger up' event, which will always cause a timeout.
+		 */
+		return 0;
+	}
 
 	touch_num = data[0] & 0x0f;
 	if (touch_num > ts->max_touch_num)
-- 
2.11.0

