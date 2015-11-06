From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH] hid: sony: Remove the size check for the Dualshock 4 HID Descriptor
Date: Fri,  6 Nov 2015 15:35:53 -0500
Message-ID: <1446842153-4231-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38170 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161863AbbKFUgO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Nov 2015 15:36:14 -0500
Received: by igbxm8 with SMTP id xm8so19016121igb.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2015 12:36:14 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@gmail.com>

Sony has modified the HID descriptor in new revisions of the Dualshock 4 which
causes the size check in the descriptor replacement function to fail.  Remove it
so that new revisions of the controller will work correctly.

The module is completely replacing the descriptor instead of patching it, so the
size check isn't really necessary anyways.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---

 This fixes the following bug:
 https://bugzilla.kernel.org/show_bug.cgi?id=107081

 drivers/hid/hid-sony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 661f94f..e38d287 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1137,11 +1137,11 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	 * the gyroscope values to corresponding axes so we need a
 	 * modified one.
 	 */
-	if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && *rsize == 467) {
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		hid_info(hdev, "Using modified Dualshock 4 report descriptor with gyroscope axes\n");
 		rdesc = dualshock4_usb_rdesc;
 		*rsize = sizeof(dualshock4_usb_rdesc);
-	} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) && *rsize == 357) {
+	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
 		hid_info(hdev, "Using modified Dualshock 4 Bluetooth report descriptor\n");
 		rdesc = dualshock4_bt_rdesc;
 		*rsize = sizeof(dualshock4_bt_rdesc);
-- 
2.4.3

