From: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>
Subject: [PATCH v2] Input: goodix: Add support for capacitive home button found on some x86 tablets
Date: Tue, 20 Jun 2017 21:08:50 +1000
Message-ID: <1749277.ynzOHhpSB9@z12>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward14m.cmail.yandex.net ([5.255.216.145]:49556 "EHLO
        forward14m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750916AbdFTLQB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 07:16:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru, "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, linux-input@vger.kernel.org

On some x86 tablets with a goodix touchscreen the windows logo on the
front is a capacitive home button. Touching this button results in a touch
with bit 4 of the first byte set, while normally only the lower 4 bits
are used to indicate the number of touches.

Detect this and report a KEY_LEFTMETA press when this happens. Note the
hardware might support more than one button, the number of a button is
reported by the 'id' byte of coor_data. Now we ignore button id.

Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>
---
 drivers/input/touchscreen/goodix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 240b16f3ee97..c1bb59c96dbd 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -267,6 +267,12 @@ static void goodix_process_events(struct goodix_ts_data *ts)
 	if (touch_num < 0)
 		return;
 
+	/*
+	 * Bit 4 of the first byte reports the status of the capacitive
+	 * Windows/Home button.
+	 */
+	input_report_key(ts->input_dev, KEY_LEFTMETA, !!(point_data[0] & 0x10));
+
 	for (i = 0; i < touch_num; i++)
 		goodix_ts_report_touch(ts,
 				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
@@ -612,6 +618,9 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 	ts->input_dev->id.product = ts->id;
 	ts->input_dev->id.version = ts->version;
 
+	/* Capacitive Windows/Home button on some devices */
+	input_set_capability(ts->input_dev, EV_KEY, KEY_LEFTMETA);
+
 	error = input_register_device(ts->input_dev);
 	if (error) {
 		dev_err(&ts->client->dev,

