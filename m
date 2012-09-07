From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] HID: waltop: Remove waltop_probe() and waltop_remove()
 functions
Date: Fri, 07 Sep 2012 15:13:24 +0800
Message-ID: <1347002004.30222.3.camel@phoenix>
References: <1347001910.30222.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48488 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab2IGHNa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Sep 2012 03:13:30 -0400
Received: by iahk25 with SMTP id k25so2932525iah.19
        for <linux-input@vger.kernel.org>; Fri, 07 Sep 2012 00:13:29 -0700 (PDT)
In-Reply-To: <1347001910.30222.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org

The waltop_probe() and waltop_remove() functions do not have any special
initialization and cleanup. Remove them and let HID core handle the default
probe/remove actions.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-waltop.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index 745e4e9..bb536ab 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -638,28 +638,6 @@ static __u8 sirius_battery_free_tablet_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-static int waltop_probe(struct hid_device *hdev,
-			const struct hid_device_id *id)
-{
-	int ret;
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "parse failed\n");
-		goto err;
-	}
-
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
-		goto err;
-	}
-
-	return 0;
-err:
-	return ret;
-}
-
 static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -776,11 +754,6 @@ static int waltop_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
-static void waltop_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static const struct hid_device_id waltop_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
 				USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
@@ -803,10 +776,8 @@ MODULE_DEVICE_TABLE(hid, waltop_devices);
 static struct hid_driver waltop_driver = {
 	.name = "waltop",
 	.id_table = waltop_devices,
-	.probe = waltop_probe,
 	.report_fixup = waltop_report_fixup,
 	.raw_event = waltop_raw_event,
-	.remove = waltop_remove,
 };
 
 static int __init waltop_init(void)
-- 
1.7.9.5



