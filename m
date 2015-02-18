From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 1/4] HID: hid-lg4ff: Identify Logitech gaming wheels in compatibility modes accordingly to Logitech specifications
Date: Wed, 18 Feb 2015 17:59:20 +0100
Message-ID: <1424278763-29072-2-git-send-email-madcatxster@devoid-pointer.net>
References: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Identify Logitech gaming wheels in compatibility modes accordingly to L=
ogitech
specifications.

Logitech specification contains a general method of identifying various
models of their gaming wheels while they are in "compatibility" mode.
This patch implements the method instead of checking against known
values of bcdDevice. Handling of the mode switch upon initialization is
also adjusted so that the driver does not have to go through the entire
initialization routine because the wheels are set to perform a USB
detach before they reappear in "native" mode.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 v3: Mark "lg4ff_identify_multimode_wheel" and "lg4ff_handle_multimode_=
wheel"
     functions static.

 drivers/hid/hid-lg4ff.c | 266 ++++++++++++++++++++++++++++++++++------=
--------
 1 file changed, 190 insertions(+), 76 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index db0dd9b..190c5e3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -32,21 +32,15 @@
 #include "hid-lg.h"
 #include "hid-ids.h"
=20
-#define DFGT_REV_MAJ 0x13
-#define DFGT_REV_MIN 0x22
-#define DFGT2_REV_MIN 0x26
-#define DFP_REV_MAJ 0x11
-#define DFP_REV_MIN 0x06
-#define FFEX_REV_MAJ 0x21
-#define FFEX_REV_MIN 0x00
-#define G25_REV_MAJ 0x12
-#define G25_REV_MIN 0x22
-#define G27_REV_MAJ 0x12
-#define G27_REV_MIN 0x38
-#define G27_2_REV_MIN 0x39
-
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
=20
+#define LG4FF_MMODE_DONE 0
+#define LG4FF_MMODE_SWITCHED 1
+#define LG4FF_MMODE_NOT_MULTIMODE 2
+
+#define LG4FF_FFEX_REV_MAJ 0x21
+#define LG4FF_FFEX_REV_MIN 0x00
+
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
 static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range)=
;
=20
@@ -77,6 +71,22 @@ struct lg4ff_wheel {
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
+struct lg4ff_compat_mode_switch {
+	const __u8 cmd_count;	/* Number of commands to send */
+	const __u8 cmd[];
+};
+
+struct lg4ff_wheel_ident_info {
+	const u16 mask;
+	const u16 result;
+	const u16 real_product_id;
+};
+
+struct lg4ff_wheel_ident_checklist {
+	const u32 count;
+	const struct lg4ff_wheel_ident_info *models[];
+};
+
 static const struct lg4ff_wheel lg4ff_devices[] =3D {
 	{USB_DEVICE_ID_LOGITECH_WHEEL,       lg4ff_wheel_effects, 40, 270, NU=
LL},
 	{USB_DEVICE_ID_LOGITECH_MOMO_WHEEL,  lg4ff_wheel_effects, 40, 270, NU=
LL},
@@ -88,48 +98,63 @@ static const struct lg4ff_wheel lg4ff_devices[] =3D=
 {
 	{USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NU=
LL}
 };
=20
-struct lg4ff_native_cmd {
-	const __u8 cmd_num;	/* Number of commands to send */
-	const __u8 cmd[];
+/* Multimode wheel identificators */
+static const struct lg4ff_wheel_ident_info lg4ff_dfp_ident_info =3D {
+	0xf000,
+	0x1000,
+	USB_DEVICE_ID_LOGITECH_DFP_WHEEL
+};
+
+static const struct lg4ff_wheel_ident_info lg4ff_g25_ident_info =3D {
+	0xff00,
+	0x1200,
+	USB_DEVICE_ID_LOGITECH_G25_WHEEL
+};
+
+static const struct lg4ff_wheel_ident_info lg4ff_g27_ident_info =3D {
+	0xfff0,
+	0x1230,
+	USB_DEVICE_ID_LOGITECH_G27_WHEEL
 };
=20
-struct lg4ff_usb_revision {
-	const __u16 rev_maj;
-	const __u16 rev_min;
-	const struct lg4ff_native_cmd *command;
+static const struct lg4ff_wheel_ident_info lg4ff_dfgt_ident_info =3D {
+	0xff00,
+	0x1300,
+	USB_DEVICE_ID_LOGITECH_DFGT_WHEEL
 };
=20
-static const struct lg4ff_native_cmd native_dfp =3D {
+/* Multimode wheel identification checklists */
+static const struct lg4ff_wheel_ident_checklist lg4ff_main_checklist =3D=
 {
+	4,
+	{&lg4ff_dfgt_ident_info,
+	 &lg4ff_g27_ident_info,
+	 &lg4ff_g25_ident_info,
+	 &lg4ff_dfp_ident_info}
+};
+
+/* Compatibility mode switching commands */
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_dfp =3D=
 {
 	1,
 	{0xf8, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00}
 };
=20
-static const struct lg4ff_native_cmd native_dfgt =3D {
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_dfgt =3D=
 {
 	2,
 	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 1st command */
 	 0xf8, 0x09, 0x03, 0x01, 0x00, 0x00, 0x00}	/* 2nd command */
 };
=20
-static const struct lg4ff_native_cmd native_g25 =3D {
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_g25 =3D=
 {
 	1,
 	{0xf8, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00}
 };
=20
-static const struct lg4ff_native_cmd native_g27 =3D {
+static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_g27 =3D=
 {
 	2,
 	{0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 1st command */
 	 0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}	/* 2nd command */
 };
=20
-static const struct lg4ff_usb_revision lg4ff_revs[] =3D {
-	{DFGT_REV_MAJ, DFGT_REV_MIN, &native_dfgt},	/* Driving Force GT */
-	{DFGT_REV_MAJ, DFGT2_REV_MIN, &native_dfgt},	/* Driving Force GT v2 *=
/
-	{DFP_REV_MAJ,  DFP_REV_MIN,  &native_dfp},	/* Driving Force Pro */
-	{G25_REV_MAJ,  G25_REV_MIN,  &native_g25},	/* G25 */
-	{G27_REV_MAJ,  G27_REV_MIN,  &native_g27},	/* G27 */
-	{G27_REV_MAJ,  G27_2_REV_MIN,  &native_g27},	/* G27 v2 */
-};
-
 /* Recalculates X axis value accordingly to currently selected range *=
/
 static __s32 lg4ff_adjust_dfp_x_axis(__s32 value, __u16 range)
 {
@@ -396,19 +421,22 @@ static void hid_lg4ff_set_range_dfp(struct hid_de=
vice *hid, __u16 range)
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 }
=20
-static void hid_lg4ff_switch_native(struct hid_device *hid, const stru=
ct lg4ff_native_cmd *cmd)
+static int lg4ff_switch_compatibility_mode(struct hid_device *hid, con=
st struct lg4ff_compat_mode_switch *s)
 {
-	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
-	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__u8 i, j;
+	struct usb_device *usbdev =3D hid_to_usb_dev(hid);
+	struct usbhid_device *usbhid =3D hid->driver_data;
+	u8 i;
=20
-	j =3D 0;
-	while (j < 7*cmd->cmd_num) {
-		for (i =3D 0; i < 7; i++)
-			report->field[0]->value[i] =3D cmd->cmd[j++];
+	for (i =3D 0; i < s->cmd_count; i++) {
+		int xferd, ret;
+		u8 data[7];
=20
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+		memcpy(data, s->cmd + (7*i), 7);
+		ret =3D usb_interrupt_msg(usbdev, usbhid->urbout->pipe, data, 7, &xf=
erd, USB_CTRL_SET_TIMEOUT);
+		if (ret)
+			return ret;
 	}
+	return 0;
 }
=20
 /* Read current range and display it in terminal */
@@ -555,20 +583,129 @@ static enum led_brightness lg4ff_led_get_brightn=
ess(struct led_classdev *led_cde
 }
 #endif
=20
+static u16 lg4ff_identify_multimode_wheel(struct hid_device *hid, cons=
t u16 reported_product_id, const u16 bcdDevice)
+{
+	const struct lg4ff_wheel_ident_checklist *checklist;
+	int i, from_idx, to_idx;
+
+	switch (reported_product_id) {
+	case USB_DEVICE_ID_LOGITECH_WHEEL:
+	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+		checklist =3D &lg4ff_main_checklist;
+		from_idx =3D 0;
+		to_idx =3D checklist->count - 1;
+		break;
+	case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+		checklist =3D &lg4ff_main_checklist;
+		from_idx =3D 0;
+		to_idx =3D checklist->count - 2; /* End identity check at G25 */
+		break;
+	case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
+		checklist =3D &lg4ff_main_checklist;
+		from_idx =3D 1; /* Start identity check at G27 */
+		to_idx =3D checklist->count - 3; /* End identity check at G27 */
+		break;
+	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+		checklist =3D &lg4ff_main_checklist;
+		from_idx =3D 0;
+		to_idx =3D checklist->count - 4; /* End identity check at DFGT */
+		break;
+	default:
+		return 0;
+	}
+
+	for (i =3D from_idx; i <=3D to_idx; i++) {
+		const u16 mask =3D checklist->models[i]->mask;
+		const u16 result =3D checklist->models[i]->result;
+		const u16 real_product_id =3D checklist->models[i]->real_product_id;
+
+		if ((bcdDevice & mask) =3D=3D result) {
+			dbg_hid("Found wheel with real PID %X whose reported PID is %X\n", =
real_product_id, reported_product_id);
+			return real_product_id;
+		}
+	}
+
+	/* No match found. This is an unknown wheel model, do not touch it */
+	dbg_hid("Wheel with bcdDevice %X was not recognized as multimode whee=
l, leaving in its current mode\n", bcdDevice);
+	return 0;
+}
+
+static int lg4ff_handle_multimode_wheel(struct hid_device *hid, u16 *r=
eal_product_id, const u16 bcdDevice)
+{
+	const u16 reported_product_id =3D hid->product;
+	int ret;
+
+	*real_product_id =3D lg4ff_identify_multimode_wheel(hid, reported_pro=
duct_id, bcdDevice);
+	/* Probed wheel is not a multimode wheel */
+	if (!*real_product_id) {
+		*real_product_id =3D reported_product_id;
+		dbg_hid("Wheel is not a multimode wheel\n");
+		return LG4FF_MMODE_NOT_MULTIMODE;
+	}
+
+	/* Switch from "Driving Force" mode to native mode automatically.
+	 * Otherwise keep the wheel in its current mode */
+	if (reported_product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL &&
+	    reported_product_id !=3D *real_product_id) {
+		const struct lg4ff_compat_mode_switch *s;
+
+		switch (*real_product_id) {
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			s =3D &lg4ff_mode_switch_dfp;
+			break;
+		case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+			s =3D &lg4ff_mode_switch_g25;
+			break;
+		case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
+			s =3D &lg4ff_mode_switch_g27;
+			break;
+		case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+			s =3D &lg4ff_mode_switch_dfgt;
+			break;
+		default:
+			hid_err(hid, "Invalid product id %X\n", *real_product_id);
+			return LG4FF_MMODE_DONE;
+		}
+
+		ret =3D lg4ff_switch_compatibility_mode(hid, s);
+		if (ret) {
+			/* Wheel could not have been switched to native mode,
+			 * leave it in "Driving Force" mode and continue */
+			hid_err(hid, "Unable to switch wheel mode, errno %d\n", ret);
+			return LG4FF_MMODE_DONE;
+		}
+		return LG4FF_MMODE_SWITCHED;
+	}
+
+	return LG4FF_MMODE_DONE;
+}
+
+
 int lg4ff_init(struct hid_device *hid)
 {
 	struct hid_input *hidinput =3D list_entry(hid->inputs.next, struct hi=
d_input, list);
 	struct input_dev *dev =3D hidinput->input;
+	const struct usb_device_descriptor *udesc =3D &(hid_to_usb_dev(hid)->=
descriptor);
+	const u16 bcdDevice =3D le16_to_cpu(udesc->bcdDevice);
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-	struct usb_device_descriptor *udesc;
-	int error, i, j;
-	__u16 bcdDevice, rev_maj, rev_min;
+	int error, i, j, ret;
+	u16 real_product_id;
=20
 	/* Check that the report looks ok */
 	if (!hid_validate_values(hid, HID_OUTPUT_REPORT, 0, 0, 7))
 		return -1;
=20
+	/* Check if a multimode wheel has been connected and
+	 * handle it appropriately */
+	ret =3D lg4ff_handle_multimode_wheel(hid, &real_product_id, bcdDevice=
);
+
+	/* Wheel has been told to switch to native mode. There is no point in=
 going on
+	 * with the initialization as the wheel will do a USB reset when it s=
witches mode
+	 */
+	if (ret =3D=3D LG4FF_MMODE_SWITCHED)
+		return 0;
+
 	/* Check what wheel has been connected */
 	for (i =3D 0; i < ARRAY_SIZE(lg4ff_devices); i++) {
 		if (hid->product =3D=3D lg4ff_devices[i].product_id) {
@@ -583,28 +720,6 @@ int lg4ff_init(struct hid_device *hid)
 		return -1;
 	}
=20
-	/* Attempt to switch wheel to native mode when applicable */
-	udesc =3D &(hid_to_usb_dev(hid)->descriptor);
-	if (!udesc) {
-		hid_err(hid, "NULL USB device descriptor\n");
-		return -1;
-	}
-	bcdDevice =3D le16_to_cpu(udesc->bcdDevice);
-	rev_maj =3D bcdDevice >> 8;
-	rev_min =3D bcdDevice & 0xff;
-
-	if (lg4ff_devices[i].product_id =3D=3D USB_DEVICE_ID_LOGITECH_WHEEL) =
{
-		dbg_hid("Generic wheel detected, can it do native?\n");
-		dbg_hid("USB revision: %2x.%02x\n", rev_maj, rev_min);
-
-		for (j =3D 0; j < ARRAY_SIZE(lg4ff_revs); j++) {
-			if (lg4ff_revs[j].rev_maj =3D=3D rev_maj && lg4ff_revs[j].rev_min =3D=
=3D rev_min) {
-				hid_lg4ff_switch_native(hid, lg4ff_revs[j].command);
-				hid_info(hid, "Switched to native mode\n");
-			}
-		}
-	}
-
 	/* Set supported force feedback capabilities */
 	for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
 		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
@@ -637,7 +752,9 @@ int lg4ff_init(struct hid_device *hid)
 	/* Check if autocentering is available and
 	 * set the centering force to zero by default */
 	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
-		if (rev_maj =3D=3D FFEX_REV_MAJ && rev_min =3D=3D FFEX_REV_MIN)	/* F=
ormula Force EX expects different autocentering command */
+		/* Formula Force EX expects different autocentering command */
+		if ((bcdDevice >> 8) =3D=3D LG4FF_FFEX_REV_MAJ &&
+		    (bcdDevice & 0xff) =3D=3D LG4FF_FFEX_REV_MIN)
 			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_ffex;
 		else
 			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_default;
@@ -711,25 +828,21 @@ out:
 	return 0;
 }
=20
-
-
 int lg4ff_deinit(struct hid_device *hid)
 {
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
=20
-	device_remove_file(&hid->dev, &dev_attr_range);
-
 	drv_data =3D hid_get_drvdata(hid);
 	if (!drv_data) {
 		hid_err(hid, "Error while deinitializing device, no private driver d=
ata.\n");
 		return -1;
 	}
 	entry =3D drv_data->device_props;
-	if (!entry) {
-		hid_err(hid, "Error while deinitializing device, no device propertie=
s data.\n");
-		return -1;
-	}
+	if (!entry)
+		goto out; /* Nothing more to do */
+
+	device_remove_file(&hid->dev, &dev_attr_range);
=20
 #ifdef CONFIG_LEDS_CLASS
 	{
@@ -752,6 +865,7 @@ int lg4ff_deinit(struct hid_device *hid)
 	/* Deallocate memory */
 	kfree(entry);
=20
+out:
 	dbg_hid("Device successfully unregistered\n");
 	return 0;
 }
--=20
2.3.0
