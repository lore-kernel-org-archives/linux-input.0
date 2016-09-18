From: Simon Wood <gitsend@mungewell.org>
Subject: [Patch-V2 5/6] HID:hid-logitech: Improve Wingman Formula Force GP support
Date: Sun, 18 Sep 2016 10:55:41 -0600
Message-ID: <1474217742-3992-5-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
 <1474217742-3992-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:53738 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbcIRQ4a (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Sep 2016 12:56:30 -0400
In-Reply-To: <1474217742-3992-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

Move ForceFeedback support for the Formula Force GP into hid-lgff4
and re-write HID descriptor, thus allowing combined pedals or not
as user desires.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-lg4ff.c |  2 ++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index ffcf4f1..76f644d 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -49,6 +49,7 @@
 #define FV_RDESC_ORIG_SIZE	130
 #define MOMO_RDESC_ORIG_SIZE	87
 #define MOMO2_RDESC_ORIG_SIZE	87
+#define FFG_RDESC_ORIG_SIZE	85
 
 /* Fixed report descriptors for Logitech Driving Force (and Pro)
  * wheel controllers
@@ -334,6 +335,52 @@ static __u8 momo2_rdesc_fixed[] = {
 0xC0                /*  End Collection                      */
 };
 
+static __u8 ffg_rdesc_fixed[] = {
+0x05, 0x01,         /*  Usage Page (Desktop),               */
+0x09, 0x04,         /*  Usage (Joystik),                    */
+0xA1, 0x01,         /*  Collection (Application),           */
+0xA1, 0x02,         /*      Collection (Logical),           */
+0x95, 0x01,         /*          Report Count (1),           */
+0x75, 0x0A,         /*          Report Size (10),           */
+0x15, 0x00,         /*          Logical Minimum (0),        */
+0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+0x35, 0x00,         /*          Physical Minimum (0),       */
+0x46, 0xFF, 0x03,   /*          Physical Maximum (1023),    */
+0x09, 0x30,         /*          Usage (X),                  */
+0x81, 0x02,         /*          Input (Variable),           */
+0x95, 0x06,         /*          Report Count (6),           */
+0x75, 0x01,         /*          Report Size (1),            */
+0x25, 0x01,         /*          Logical Maximum (1),        */
+0x45, 0x01,         /*          Physical Maximum (1),       */
+0x05, 0x09,         /*          Usage Page (Button),        */
+0x19, 0x01,         /*          Usage Minimum (01h),        */
+0x29, 0x06,         /*          Usage Maximum (06h),        */
+0x81, 0x02,         /*          Input (Variable),           */
+0x95, 0x01,         /*          Report Count (1),           */
+0x75, 0x08,         /*          Report Size (8),            */
+0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+0x46, 0xFF, 0x00,   /*          Physical Maximum (255),     */
+0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+0x09, 0x01,         /*          Usage (01h),                */
+0x81, 0x02,         /*          Input (Variable),           */
+0x05, 0x01,         /*          Usage Page (Desktop),       */
+0x81, 0x01,         /*          Input (Constant),           */
+0x09, 0x31,         /*          Usage (Y),                  */
+0x81, 0x02,         /*          Input (Variable),           */
+0x09, 0x32,         /*          Usage (Z),                  */
+0x81, 0x02,         /*          Input (Variable),           */
+0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+0x09, 0x01,         /*          Usage (01h),                */
+0x81, 0x02,         /*          Input (Variable),           */
+0xC0,               /*      End Collection,                 */
+0xA1, 0x02,         /*      Collection (Logical),           */
+0x09, 0x02,         /*          Usage (02h),                */
+0x95, 0x07,         /*          Report Count (7),           */
+0x91, 0x02,         /*          Output (Variable),          */
+0xC0,               /*      End Collection,                 */
+0xC0                /*  End Collection                      */
+};
+
 /*
  * Certain Logitech keyboards send in report #3 keys which are far
  * above the logical maximum described in descriptor. This extends
@@ -361,6 +408,15 @@ static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 	switch (hdev->product) {
 
+	case USB_DEVICE_ID_LOGITECH_WINGMAN_FFG:
+		if (*rsize == FFG_RDESC_ORIG_SIZE) {
+			hid_info(hdev,
+				"fixing up Logitech Wingman Formula Force GP report descriptor\n");
+			rdesc = ffg_rdesc_fixed;
+			*rsize = sizeof(ffg_rdesc_fixed);
+		}
+		break;
+
 	/* Several wheels report as this id when operating in emulation mode. */
 	case USB_DEVICE_ID_LOGITECH_WHEEL:
 		if (*rsize == DF_RDESC_ORIG_SIZE) {
@@ -608,6 +664,7 @@ static int lg_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 			usage->code == ABS_RZ)) {
 		switch (hdev->product) {
 		case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+		case USB_DEVICE_ID_LOGITECH_WINGMAN_FFG:
 		case USB_DEVICE_ID_LOGITECH_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
@@ -807,7 +864,7 @@ static const struct hid_device_id lg_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII_WHEEL),
 		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
-		.driver_data = LG_FF },
+		.driver_data = LG_NOGET | LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
 		.driver_data = LG_FF2 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index cc5c9ebd..1fc12e3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -137,6 +137,7 @@ struct lg4ff_alternate_mode {
 };
 
 static const struct lg4ff_wheel lg4ff_devices[] = {
+	{USB_DEVICE_ID_LOGITECH_WINGMAN_FFG, lg4ff_wheel_effects, 40, 180, NULL},
 	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270, NULL},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270, NULL},
 	{USB_DEVICE_ID_LOGITECH_DFP_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_dfp},
@@ -345,6 +346,7 @@ int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
 			rd[5] = rd[3];
 			rd[6] = 0x7F;
 			return 1;
+		case USB_DEVICE_ID_LOGITECH_WINGMAN_FFG:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
 			rd[4] = rd[3];
-- 
2.7.4

