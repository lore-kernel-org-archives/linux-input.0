From: CheChun Kuo <vichy.kuo@gmail.com>
Subject: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for next hid_start_in
Date: Fri, 22 Aug 2014 15:35:13 +0800
Message-ID: <1408692913-12336-1-git-send-email-vichy.kuo@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35832 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbaHVHgB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2014 03:36:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: jkosina@suse.cz, CheChun Kuo <vichy.kuo@gmail.com>

	HID IR device will not response to any command send from host when it is finishing paring and tring to reset itself.
During this period of time, usb_cleaer_halt will be fail and if hid_start_in soon again, we has the possibility trap in infinite loop.

Signed-off-by: CheChun Kuo <vichy.kuo@gmail.com>
---
 drivers/hid/usbhid/hid-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 79cf503..256b102 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -122,7 +122,8 @@ static void hid_reset(struct work_struct *work)
 		dev_dbg(&usbhid->intf->dev, "clear halt\n");
 		rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
 		clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
-		hid_start_in(hid);
+		if (rc == 0)
+			hid_start_in(hid);
 	}
 
 	else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
-- 
1.7.9.5

