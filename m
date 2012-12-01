From: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 4/4] HID: i2c-hid: LED input events handling
Date: Sat,  1 Dec 2012 16:07:21 -0300
Message-ID: <1354388841-23854-5-git-send-email-andre.guedes@openbossa.org>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42104 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2LATHr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2012 14:07:47 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so497377vby.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 11:07:47 -0800 (PST)
In-Reply-To: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

This patch removes code for handling LED input events from i2c_hid_
hidinput_input_event and call hidinput_led_output_report helper
instead.

In consequence, i2c-hid driver is now sending LED output
reports to device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 67ab5b7..e4722d3 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -701,8 +701,6 @@ static int i2c_hid_hidinput_input_event(struct input_dev *dev,
 		unsigned int type, unsigned int code, int value)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
-	struct hid_field *field;
-	int offset;
 
 	if (type == EV_FF)
 		return input_ff_event(dev, type, code, value);
@@ -710,14 +708,7 @@ static int i2c_hid_hidinput_input_event(struct input_dev *dev,
 	if (type != EV_LED)
 		return -1;
 
-	offset = hidinput_find_field(hid, type, code, &field);
-
-	if (offset == -1) {
-		hid_warn(dev, "event field not found\n");
-		return -1;
-	}
-
-	hid_set_field(field, offset, value);
+	hidinput_led_output_report(hid, code, value);
 
 	return 0;
 }
-- 
1.8.0.1

