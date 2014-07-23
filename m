From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 2/5] hid: huion: Invert in-range on specific product
Date: Wed, 23 Jul 2014 15:42:55 +0300
Message-ID: <1406119378-24551-3-git-send-email-spbnick@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44524 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaGWMnW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 08:43:22 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so7708232wiv.5
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 05:43:21 -0700 (PDT)
In-Reply-To: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Limit inverting the in-range bit in raw reports to tablet product ID
only. This will make adding handling of other, non-tablet products,
easier.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-huion.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index 25d01cd..db24472 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -151,9 +151,15 @@ err:
 static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
 			u8 *data, int size)
 {
-	/* If this is a pen input report then invert the in-range bit */
-	if (report->type == HID_INPUT_REPORT && report->id == 0x07 && size >= 2)
-		data[1] ^= 0x40;
+	switch (hdev->product) {
+	case USB_DEVICE_ID_HUION_TABLET:
+		/* If this is a pen input report */
+		if (report->type == HID_INPUT_REPORT &&
+		    report->id == 0x07 && size >= 2)
+			/* Invert the in-range bit */
+			data[1] ^= 0x40;
+		break;
+	}
 
 	return 0;
 }
-- 
2.0.1

