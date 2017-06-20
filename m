From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v3] Input: goodix: Add support for capacitive home button
Date: Tue, 20 Jun 2017 18:08:35 +0200
Message-ID: <20170620160835.13904-1-hadess@hadess.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47085 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTQJU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 12:09:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, "Sergei A. Trusov" <sergei.a.trusov@ya.ru>

From: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>

On some x86 tablets with a Goodix touchscreen, the Windows logo on the
front is a capacitive home button. Touching this button results in a touch
with bit 4 of the first byte set, while only the lower 4 bits (0-3) are
used to indicate the number of touches.

Report a KEY_LEFTMETA press when this happens.

Note that the hardware might support more than one button, in which
case the "id" byte of coor_data would identify the button in question.
This is not implemented as we don't have access to hardware with
multiple buttons.

Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>
Acked-by: Bastien Nocera <hadess@hadess.net>
---

Changes from v2:
 - commit message fixes
 - use BIT(4) instead of 0x10

 drivers/input/touchscreen/goodix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 240b16f3ee97..903137d9cf7d 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -267,6 +267,12 @@ static void goodix_process_events(struct goodix_ts_data *ts)
 	if (touch_num < 0)
 		return;
 
+	/*
+	 * Bit 4 of the first byte reports the status of the capacitive
+	 * Windows/Home button.
+	 */
+	input_report_key(ts->input_dev, KEY_LEFTMETA, !!(point_data[0] & BIT(4)));
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
-- 
2.13.0

