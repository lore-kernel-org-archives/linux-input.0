From: simon@mungewell.org
Subject: Re: [PATCH] HID: hid-lg: Add USBID for Logitech G29 Wheel
Date: Wed, 2 Sep 2015 22:02:11 -0400
Message-ID: <b2304f1d8d35f61bed3ae24ca68add18.squirrel@mungewell.org>
References: <1437700203-4546-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20150902220210_17825"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:48598 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbICCxm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Sep 2015 22:53:42 -0400
In-Reply-To: <1437700203-4546-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>

------=_20150902220210_17825
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> I do not have this wheel to test with, but this should at least get it
> working in emulation mode.
>
> Note: There is probably more work required for adjust HID descriptor and
> handle switching between emulation and native modes.

I was able to get some more information, but as yet have not been able to
get time on the real hardware. Attached is a 2nd patch which should
improve the support, I'll formally submit it next week.... But if anyone
can test it first that would be great.

There's a pre-built Debian/Ubuntu kernel here:
https://dl.dropboxusercontent.com/u/34518077/linux-headers-4.2.0-g29%2B_20150831_i386.deb
https://dl.dropboxusercontent.com/u/34518077/linux-image-4.2.0-g29%2B_20150831_i386.deb

The wheel will need to be in PS3 mode set with switch behind LEDs, and
should connect first as a DF-EX (220' turn) and then automatically
reconnect as G29 (900' turn).

The mode should be selectable something like
--
root@retrobox:/home/simon# cd /sys/bus/hid/devices/0003\:046D\:C29B.0002
root@retrobox:/sys/bus/hid/devices/0003:046D:C29B.0002# ls
alternate_modes  country  driver  hidraw  input  leds  modalias  power 
range  real_id  report_descriptor  subsystem  uevent
root@retrobox:/sys/bus/hid/devices/0003:046D:C29B.0002# cat alternate_modes
native: G27 Racing Wheel *
DF-EX: Driving Force / Formula EX
DFP: Driving Force Pro
G25: G25 Racing Wheel
G27: G27 Racing Wheel *
root@retrobox:/sys/bus/hid/devices/0003:046D:C29B.0002# echo G25 >
alternate_modes
--

The LEDs should also work
--
root@retrobox:/home/simon/linux-git# cd /sys/class/leds/
root@retrobox:/sys/class/leds# ls
0003:046D:C29B.0005::RPM1  0003:046D:C29B.0005::RPM4  input3::numlock    
tpacpi::power       tpacpi::thinkvantage
0003:046D:C29B.0005::RPM2  0003:046D:C29B.0005::RPM5  input3::scrolllock 
tpacpi::standby
0003:046D:C29B.0005::RPM3  input3::capslock           phy0-led           
tpacpi::thinklight
root@retrobox:/sys/class/leds# echo 1 >
0003\:046D\:C29B.0005\:\:RPM1/brightness
--

Cheers,
Simon
------=_20150902220210_17825
Content-Type: text/x-patch; name="g29_ps3.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="g29_ps3.patch"

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..2e9c706 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1874,6 +1874,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G29_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 02cec83..d0c3da5 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -45,7 +45,8 @@
 #define LG4FF_MODE_G25_IDX 3
 #define LG4FF_MODE_DFGT_IDX 4
 #define LG4FF_MODE_G27_IDX 5
-#define LG4FF_MODE_MAX_IDX 6
+#define LG4FF_MODE_G29_IDX 6
+#define LG4FF_MODE_MAX_IDX 7
 
 #define LG4FF_MODE_NATIVE BIT(LG4FF_MODE_NATIVE_IDX)
 #define LG4FF_MODE_DFEX BIT(LG4FF_MODE_DFEX_IDX)
@@ -53,6 +54,7 @@
 #define LG4FF_MODE_G25 BIT(LG4FF_MODE_G25_IDX)
 #define LG4FF_MODE_DFGT BIT(LG4FF_MODE_DFGT_IDX)
 #define LG4FF_MODE_G27 BIT(LG4FF_MODE_G27_IDX)
+#define LG4FF_MODE_G29 BIT(LG4FF_MODE_G29_IDX)
 
 #define LG4FF_DFEX_TAG "DF-EX"
 #define LG4FF_DFEX_NAME "Driving Force / Formula EX"
@@ -62,6 +64,8 @@
 #define LG4FF_G25_NAME "G25 Racing Wheel"
 #define LG4FF_G27_TAG "G27"
 #define LG4FF_G27_NAME "G27 Racing Wheel"
+#define LG4FF_G29_TAG "G29"
+#define LG4FF_G29_NAME "G29 Racing Wheel"
 #define LG4FF_DFGT_TAG "DFGT"
 #define LG4FF_DFGT_NAME "Driving Force GT"
 
@@ -144,6 +148,7 @@ static const struct lg4ff_wheel lg4ff_devices[] = {
 	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_G29_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270, NULL},
 	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NULL}
 };
@@ -161,6 +166,9 @@ static const struct lg4ff_multimode_wheel lg4ff_multimode_wheels[] = {
 	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,
 	 LG4FF_MODE_NATIVE | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
 	 LG4FF_G27_TAG, LG4FF_G27_NAME},
+	{USB_DEVICE_ID_LOGITECH_G29_WHEEL,
+	 LG4FF_MODE_NATIVE | LG4FF_MODE_G29 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP,
+	 LG4FF_G29_TAG, LG4FF_G29_NAME},
 };
 
 static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
@@ -169,7 +177,8 @@ static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
 	[LG4FF_MODE_DFP_IDX] = {USB_DEVICE_ID_LOGITECH_DFP_WHEEL, LG4FF_DFP_TAG, LG4FF_DFP_NAME},
 	[LG4FF_MODE_G25_IDX] = {USB_DEVICE_ID_LOGITECH_G25_WHEEL, LG4FF_G25_TAG, LG4FF_G25_NAME},
 	[LG4FF_MODE_DFGT_IDX] = {USB_DEVICE_ID_LOGITECH_DFGT_WHEEL, LG4FF_DFGT_TAG, LG4FF_DFGT_NAME},
-	[LG4FF_MODE_G27_IDX] = {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27_TAG, LG4FF_G27_NAME}
+	[LG4FF_MODE_G27_IDX] = {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27_TAG, LG4FF_G27_NAME},
+	[LG4FF_MODE_G29_IDX] = {USB_DEVICE_ID_LOGITECH_G29_WHEEL, LG4FF_G29_TAG, LG4FF_G29_NAME}
 };
 
 /* Multimode wheel identificators */
@@ -197,10 +206,17 @@ static const struct lg4ff_wheel_ident_info lg4ff_dfgt_ident_info = {
 	USB_DEVICE_ID_LOGITECH_DFGT_WHEEL
 };
 
+static const struct lg4ff_wheel_ident_info lg4ff_g29_ident_info = {
+	0xfff0,
+	0x1350,
+	USB_DEVICE_ID_LOGITECH_G29_WHEEL
+};
+
 /* Multimode wheel identification checklists */
 static const struct lg4ff_wheel_ident_checklist lg4ff_main_checklist = {
-	4,
-	{&lg4ff_dfgt_ident_info,
+	5,
+	{&lg4ff_g29_ident_info,
+	 &lg4ff_dfgt_ident_info,
 	 &lg4ff_g27_ident_info,
 	 &lg4ff_g25_ident_info,
 	 &lg4ff_dfp_ident_info}
@@ -238,6 +254,12 @@ static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g27 = {
 	 0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to G27 with detach */
 };
 
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g29 = {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB reset */
+	 0xf8, 0x09, 0x05, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to G29 with detach */
+};
+
 /* EXT_CMD1 - Understood by DFP, G25, G27 and DFGT */
 static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext01_dfp = {
 	1,
@@ -651,6 +673,19 @@ static const struct lg4ff_compat_mode_switch *lg4ff_get_mode_switch_command(cons
 			return NULL;
 		}
 		break;
+	case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+		switch (target_product_id) {
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfp;
+		case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfgt;
+		case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+			return &lg4ff_mode_switch_ext09_g29;
+		/* G29 can only be switched to DFP, DFGT or its native mode */
+		default:
+			return NULL;
+		}
+		break;
 	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
 		switch (target_product_id) {
 		case USB_DEVICE_ID_LOGITECH_WHEEL:
@@ -1049,12 +1084,12 @@ static u16 lg4ff_identify_multimode_wheel(struct hid_device *hid, const u16 repo
 		break;
 	case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
 		checklist = &lg4ff_main_checklist;
-		from_idx = 0;
+		from_idx = 1;
 		to_idx = checklist->count - 2; /* End identity check at G25 */
 		break;
 	case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
 		checklist = &lg4ff_main_checklist;
-		from_idx = 1; /* Start identity check at G27 */
+		from_idx = 2; /* Start identity check at G27 */
 		to_idx = checklist->count - 3; /* End identity check at G27 */
 		break;
 	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
@@ -1062,6 +1097,9 @@ static u16 lg4ff_identify_multimode_wheel(struct hid_device *hid, const u16 repo
 		from_idx = 0;
 		to_idx = checklist->count - 4; /* End identity check at DFGT */
 		break;
+	case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+		/* G29 can only be in native mode */
+		return USB_DEVICE_ID_LOGITECH_G29_WHEEL;
 	default:
 		return 0;
 	}
@@ -1251,7 +1289,8 @@ int lg4ff_init(struct hid_device *hid)
 	for (j = 0; j < 5; j++)
 		entry->wdata.led[j] = NULL;
 
-	if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL) {
+	if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL ||
+			lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G29_WHEEL) {
 		struct led_classdev *led;
 		size_t name_sz;
 		char *name;
------=_20150902220210_17825--


