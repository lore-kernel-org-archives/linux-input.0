From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] HID: primax: Remove px_probe() and px_remove() functions
Date: Fri, 07 Sep 2012 15:11:50 +0800
Message-ID: <1347001910.30222.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43227 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab2IGHL6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Sep 2012 03:11:58 -0400
Received: by ieje11 with SMTP id e11so4522102iej.19
        for <linux-input@vger.kernel.org>; Fri, 07 Sep 2012 00:11:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Terry Lambert <tlambert@google.com>, linux-input@vger.kernel.org

The px_probe() and px_remove() functions do not have any special initialization
and cleanup. Remove them and let HID core handle the default probe/remove
actions.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-primax.c |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c
index 4d3c60d..c15adb0 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -64,29 +64,6 @@ static int px_raw_event(struct hid_device *hid, struct hid_report *report,
 	return 0;
 }
 
-static int px_probe(struct hid_device *hid, const struct hid_device_id *id)
-{
-	int ret;
-
-	ret = hid_parse(hid);
-	if (ret) {
-		hid_err(hid, "parse failed\n");
-		goto fail;
-	}
-
-	ret = hid_hw_start(hid, HID_CONNECT_DEFAULT);
-	if (ret)
-		hid_err(hid, "hw start failed\n");
-
-fail:
-	return ret;
-}
-
-static void px_remove(struct hid_device *hid)
-{
-	hid_hw_stop(hid);
-}
-
 static const struct hid_device_id px_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
 	{ }
@@ -97,8 +74,6 @@ static struct hid_driver px_driver = {
 	.name = "primax",
 	.id_table = px_devices,
 	.raw_event = px_raw_event,
-	.probe = px_probe,
-	.remove = px_remove,
 };
 
 static int __init px_init(void)
-- 
1.7.9.5



