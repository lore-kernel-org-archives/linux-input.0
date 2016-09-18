From: Simon Wood <gitsend@mungewell.org>
Subject: [Patch-V2 4/6] HID:hid-logitech: Rewrite of descriptor for all DF wheels
Date: Sun, 18 Sep 2016 10:55:40 -0600
Message-ID: <1474217742-3992-4-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
 <1474217742-3992-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474217742-3992-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Rewrite the HID descriptor for _all_ Driving Force wheels (real
or emulated) so that they can report separate Accelerator and
Brake axis.

If the user wants a combined accel/brake axis, they can use the
'combined pedals' feature.

$ echo 1 > /sys/bus/hid/devices/<device-id>/combine_pedals

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 06f8a5e..ffcf4f1 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -343,8 +343,6 @@ static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
-	struct usb_device_descriptor *udesc;
-	__u16 bcdDevice, rev_maj, rev_min;
 
 	if ((drv_data->quirks & LG_RDESC) && *rsize >= 91 && rdesc[83] == 0x26 &&
 			rdesc[84] == 0x8c && rdesc[85] == 0x02) {
@@ -365,18 +363,7 @@ static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
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
