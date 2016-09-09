From: Simon Wood <gitsend@mungewell.org>
Subject: [PATCH 4/5] HID:hid-logitech: Rewrite of descriptor for all DF wheels
Date: Fri,  9 Sep 2016 16:50:48 -0600
Message-ID: <1473461449-8060-4-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:49210 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755722AbcIIWv3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2016 18:51:29 -0400
In-Reply-To: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

Rewrite the HID descriptor for _all_ Driving Force wheels (real
or emulated) so that they can report separate Accelerator and
Brake axis.

If the user wants a combined accel/brake axis, they can use the
'combined pedals' feature.

$ echo 1 > /sys/bus/hid/devices/<device-id>/combine_pedals

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 06f8a5e..53429c6 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -365,18 +365,7 @@ static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 	/* Several wheels report as this id when operating in emulation mode. */
 	case USB_DEVICE_ID_LOGITECH_WHEEL:
-		udesc = &(hid_to_usb_dev(hdev)->descriptor);
-		if (!udesc) {
-			hid_err(hdev, "NULL USB device descriptor\n");
-			break;
-		}
-		bcdDevice = le16_to_cpu(udesc->bcdDevice);
-		rev_maj = bcdDevice >> 8;
-		rev_min = bcdDevice & 0xff;
-
-		/* Update the report descriptor for only the Driving Force wheel */
-		if (rev_maj == 1 && rev_min == 2 &&
-				*rsize == DF_RDESC_ORIG_SIZE) {
+		if (*rsize == DF_RDESC_ORIG_SIZE) {
 			hid_info(hdev,
 				"fixing up Logitech Driving Force report descriptor\n");
 			rdesc = df_rdesc_fixed;
-- 
2.7.4

