From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: goodix - Poll the 'buffer status' bit before
 reading data
Date: Fri, 13 Oct 2017 11:20:56 -0700
Message-ID: <20171013182056.ktgrsofuwu2powo5@dtor-ws>
References: <20171013174139.32125-1-hdegoede@redhat.com>
 <1507917540.5910.40.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43317 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbdJMSVA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 14:21:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id s75so968017pgs.0
        for <linux-input@vger.kernel.org>; Fri, 13 Oct 2017 11:21:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1507917540.5910.40.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, russianneuromancer@ya.ru

On Fri, Oct 13, 2017 at 07:59:00PM +0200, Bastien Nocera wrote:
> On Fri, 2017-10-13 at 19:41 +0200, Hans de Goede wrote:
> > +       const int timeout = 20;
> 
> I meant rather something like:
> #define GOODIX_BUFFER_STATUS_TIMEOUT 20
> 
> Feel free to add my Reviewed-by after this change is made.
> 

How about below?

-- 
Dmitry

Input: goodix - poll the 'buffer status' bit before reading data

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
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/goodix.c |   67 ++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 84df27326b53..699179a3c297 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -71,6 +71,9 @@ struct goodix_ts_data {
 #define GOODIX_REG_CONFIG_DATA		0x8047
 #define GOODIX_REG_ID			0x8140
 
+#define GOODIX_BUFFER_STATUS_READY	BIT(7)
+#define GOODIX_BUFFER_STATUS_TIMEOUT	20
+
 #define RESOLUTION_LOC		1
 #define MAX_CONTACTS_LOC	5
 #define TRIGGER_LOC		6
@@ -194,35 +197,53 @@ static int goodix_get_cfg_len(u16 id)
 
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
+		if (data[0] & GOODIX_BUFFER_STATUS_READY) {
+			touch_num = data[0] & 0x0f;
+			if (touch_num > ts->max_touch_num)
+				return -EPROTO;
+
+			if (touch_num > 1) {
+				data += 1 + GOODIX_CONTACT_SIZE;
+				error = goodix_i2c_read(ts->client,
+						GOODIX_READ_COOR_ADDR +
+							1 + GOODIX_CONTACT_SIZE,
+						data,
+						GOODIX_CONTACT_SIZE *
+							(touch_num - 1));
+				if (error)
+					return error;
+			}
+
+			return touch_num;
+		}
 
-	touch_num = data[0] & 0x0f;
-	if (touch_num > ts->max_touch_num)
-		return -EPROTO;
-
-	if (touch_num > 1) {
-		data += 1 + GOODIX_CONTACT_SIZE;
-		error = goodix_i2c_read(ts->client,
-					GOODIX_READ_COOR_ADDR +
-						1 + GOODIX_CONTACT_SIZE,
-					data,
-					GOODIX_CONTACT_SIZE * (touch_num - 1));
-		if (error)
-			return error;
-	}
+		usleep_range(1000, 2000); /* Poll every 1 - 2 ms */
+	} while (time_before(jiffies, max_timeout));
 
-	return touch_num;
+	/*
+	 * The Goodix panel will send spurious interrupts after a
+	 * 'finger up' event, which will always cause a timeout.
+	 */
+	return 0;
 }
 
 static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
