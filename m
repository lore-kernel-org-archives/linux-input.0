From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 5/8] HID: i2c: use generic hidinput_input_event()
Date: Mon, 15 Jul 2013 19:10:14 +0200
Message-ID: <1373908217-16748-6-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:44730 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3GORKo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:44 -0400
Received: by mail-ee0-f44.google.com with SMTP id c13so7809492eek.31
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:43 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

HID core provides the same functionality, so drop the custom handler.
Besides, the current handler doesn't schedule any outgoing report so it
did not work, anyway.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 879b0ed..db2253b 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -756,29 +756,6 @@ static int i2c_hid_power(struct hid_device *hid, int lvl)
 	return ret;
 }
 
-static int i2c_hid_hidinput_input_event(struct input_dev *dev,
-		unsigned int type, unsigned int code, int value)
-{
-	struct hid_device *hid = input_get_drvdata(dev);
-	struct hid_field *field;
-	int offset;
-
-	if (type == EV_FF)
-		return input_ff_event(dev, type, code, value);
-
-	if (type != EV_LED)
-		return -1;
-
-	offset = hidinput_find_field(hid, type, code, &field);
-
-	if (offset == -1) {
-		hid_warn(dev, "event field not found\n");
-		return -1;
-	}
-
-	return hid_set_field(field, offset, value);
-}
-
 static struct hid_ll_driver i2c_hid_ll_driver = {
 	.parse = i2c_hid_parse,
 	.start = i2c_hid_start,
@@ -787,7 +764,6 @@ static struct hid_ll_driver i2c_hid_ll_driver = {
 	.close = i2c_hid_close,
 	.power = i2c_hid_power,
 	.request = i2c_hid_request,
-	.hidinput_input_event = i2c_hid_hidinput_input_event,
 };
 
 static int i2c_hid_init_irq(struct i2c_client *client)
-- 
1.8.3.2

