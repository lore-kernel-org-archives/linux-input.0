From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 3/5] hid: huion: Don't ignore other interfaces
Date: Wed, 23 Jul 2014 15:42:56 +0300
Message-ID: <1406119378-24551-4-git-send-email-spbnick@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:52851 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbaGWMnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 08:43:24 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1139630wes.20
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 05:43:23 -0700 (PDT)
In-Reply-To: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Don't ignore non pen-reporting interfaces as they may be used by some
models reusing the same product ID.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-huion.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index db24472..e5f1e22 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -107,17 +107,6 @@ static int huion_tablet_enable(struct hid_device *hdev)
 static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
-
-	/* Ignore interfaces 1 (mouse) and 2 (keyboard) for tablet,
-	 * as they are not used
-	 */
-	switch (id->product) {
-	case USB_DEVICE_ID_HUION_TABLET:
-		if (intf->cur_altsetting->desc.bInterfaceNumber != 0x00)
-			return -ENODEV;
-		break;
-	}
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -151,10 +140,13 @@ err:
 static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
 			u8 *data, int size)
 {
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
 	switch (hdev->product) {
 	case USB_DEVICE_ID_HUION_TABLET:
 		/* If this is a pen input report */
-		if (report->type == HID_INPUT_REPORT &&
+		if (intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
+		    report->type == HID_INPUT_REPORT &&
 		    report->id == 0x07 && size >= 2)
 			/* Invert the in-range bit */
 			data[1] ^= 0x40;
-- 
2.0.1

