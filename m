From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/2] HID: hid-logitech: Add support for G29
Date: Mon,  2 Nov 2015 07:56:52 -0700
Message-ID: <1446476212-2289-2-git-send-email-simon@mungewell.org>
References: <1446476212-2289-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446476212-2289-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

At present the G29 is mis-identified as a DFGT, this patch ensures
that the wheel is correctly detected and allows setting the LEDs and
turning range via the '/sys' interface.

This wheel can also emulate other types of Logitech wheels.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-core.c  |  1 +
 drivers/hid/hid-lg.c    |  9 ++++++++
 drivers/hid/hid-lg4ff.c | 57 +++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 70a11ac..949d804 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1896,6 +1896,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G29_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 5332fb7..c20ac76 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -620,6 +620,7 @@ static int lg_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 			usage->code == ABS_Y || usage->code == ABS_Z ||
 			usage->code == ABS_RZ)) {
 		switch (hdev->product) {
+		case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
@@ -658,10 +659,18 @@ static int lg_event(struct hid_device *hdev, struct hid_field *field,
 
 static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
+	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
+	__u8 iface_num = iface->cur_altsetting->desc.bInterfaceNumber;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 	struct lg_drv_data *drv_data;
 	int ret;
 
+	/* Only work with the 1st interface (G29 presents multiple) */
+	if (iface_num != 0) {
+		dbg_hid("%s: ignoring ifnum %d\n", __func__, iface_num);
+		return -ENODEV;
+	}
+
 	drv_data = kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
 	if (!drv_data) {
 		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index b363d88..fbddcb3 100644
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
 
@@ -140,6 +144,7 @@ static const struct lg4ff_wheel lg4ff_devices[] = {
 	{USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
+	{USB_DEVICE_ID_LOGITECH_G29_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270, NULL},
 	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NULL}
 };
@@ -157,6 +162,9 @@ static const struct lg4ff_multimode_wheel lg4ff_multimode_wheels[] = {
 	{USB_DEVICE_ID_LOGITECH_G27_WHEEL,
 	 LG4FF_MODE_NATIVE | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
 	 LG4FF_G27_TAG, LG4FF_G27_NAME},
+	{USB_DEVICE_ID_LOGITECH_G29_WHEEL,
+	 LG4FF_MODE_NATIVE | LG4FF_MODE_G29 | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
+	 LG4FF_G29_TAG, LG4FF_G29_NAME},
 };
 
 static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
@@ -165,7 +173,8 @@ static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
 	[LG4FF_MODE_DFP_IDX] = {USB_DEVICE_ID_LOGITECH_DFP_WHEEL, LG4FF_DFP_TAG, LG4FF_DFP_NAME},
 	[LG4FF_MODE_G25_IDX] = {USB_DEVICE_ID_LOGITECH_G25_WHEEL, LG4FF_G25_TAG, LG4FF_G25_NAME},
 	[LG4FF_MODE_DFGT_IDX] = {USB_DEVICE_ID_LOGITECH_DFGT_WHEEL, LG4FF_DFGT_TAG, LG4FF_DFGT_NAME},
-	[LG4FF_MODE_G27_IDX] = {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27_TAG, LG4FF_G27_NAME}
+	[LG4FF_MODE_G27_IDX] = {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27_TAG, LG4FF_G27_NAME},
+	[LG4FF_MODE_G29_IDX] = {USB_DEVICE_ID_LOGITECH_G29_WHEEL, LG4FF_G29_TAG, LG4FF_G29_NAME},
 };
 
 /* Multimode wheel identificators */
@@ -197,8 +206,24 @@ static const struct lg4ff_wheel_ident_info lg4ff_dfgt_ident_info = {
 	USB_DEVICE_ID_LOGITECH_DFGT_WHEEL
 };
 
+static const struct lg4ff_wheel_ident_info lg4ff_g29_ident_info = {
+	LG4FF_MODE_G29 | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
+	0xfff8,
+	0x1350,
+	USB_DEVICE_ID_LOGITECH_G29_WHEEL
+};
+
+static const struct lg4ff_wheel_ident_info lg4ff_g29_ident_info2 = {
+	LG4FF_MODE_G29 | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
+	0xff00,
+	0x8900,
+	USB_DEVICE_ID_LOGITECH_G29_WHEEL
+};
+
 /* Multimode wheel identification checklists */
 static const struct lg4ff_wheel_ident_info *lg4ff_main_checklist[] = {
+	&lg4ff_g29_ident_info,
+	&lg4ff_g29_ident_info2,
 	&lg4ff_dfgt_ident_info,
 	&lg4ff_g27_ident_info,
 	&lg4ff_g25_ident_info,
@@ -237,6 +262,12 @@ static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g27 = {
 	 0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}	/* Switch mode to G27 with detach */
 };
 
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g29 = {
+	2,
+	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* Revert mode upon USB reset */
+	 0xf8, 0x09, 0x05, 0x01, 0x01, 0x00, 0x00}	/* Switch mode to G29 with detach */
+};
+
 /* EXT_CMD1 - Understood by DFP, G25, G27 and DFGT */
 static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext01_dfp = {
 	1,
@@ -650,6 +681,23 @@ static const struct lg4ff_compat_mode_switch *lg4ff_get_mode_switch_command(cons
 			return NULL;
 		}
 		break;
+	case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+		switch (target_product_id) {
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfp;
+		case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+			return &lg4ff_mode_switch_ext09_dfgt;
+		case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+			return &lg4ff_mode_switch_ext09_g25;
+		case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
+			return &lg4ff_mode_switch_ext09_g27;
+		case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+			return &lg4ff_mode_switch_ext09_g29;
+		/* G29 can only be switched to DF-EX, DFP, DFGT, G25, G27 or its native mode */
+		default:
+			return NULL;
+		}
+		break;
 	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
 		switch (target_product_id) {
 		case USB_DEVICE_ID_LOGITECH_WHEEL:
@@ -1232,12 +1280,13 @@ int lg4ff_init(struct hid_device *hid)
 		entry->wdata.set_range(hid, entry->wdata.range);
 
 #ifdef CONFIG_LEDS_CLASS
-	/* register led subsystem - G27 only */
+	/* register led subsystem - G27/G29 only */
 	entry->wdata.led_state = 0;
 	for (j = 0; j < 5; j++)
 		entry->wdata.led[j] = NULL;
 
-	if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL) {
+	if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL ||
+			lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G29_WHEEL) {
 		struct led_classdev *led;
 		size_t name_sz;
 		char *name;
-- 
2.1.4
