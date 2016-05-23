From: Chris J Arges <christopherarges@gmail.com>
Subject: [PATCH] Input: wacom_w8001 - Ignore bogus idx values in interrupt
Date: Sun, 22 May 2016 20:42:23 -0500
Message-ID: <1463967746-15336-1-git-send-email-christopherarges@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36715 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcEWBm3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 May 2016 21:42:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris J Arges <christopherarges@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, linux-kernel@vger.kernel.org

I've noticed crashes when using my x60t using a coreboot bios. When using
the pen I can produce a crash simply by tapping a few times. This
generates an event which has an idx of 0xc. This in turn crashes the
machine because the array access is greater than W8001_MAX_LENGTH. This
patch checks for bogus values and filters them in order to prevent crashes.

Signed-off-by: Chris J Arges <christopherarges@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index bab3c6a..c858200 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -283,6 +283,15 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 	unsigned char tmp;
 
 	w8001->data[w8001->idx] = data;
+
+	/* ignore bogus idx values */
+	if (w8001->idx >= W8001_MAX_LENGTH) {
+		pr_info("w8001: ignored interrupt: data 0x%02x idx %d\n", data,
+			w8001->idx);
+		w8001->idx = 0;
+		return IRQ_HANDLED;
+	}
+
 	switch (w8001->idx++) {
 	case 0:
 		if ((data & W8001_LEAD_MASK) != W8001_LEAD_BYTE) {
-- 
2.7.4

