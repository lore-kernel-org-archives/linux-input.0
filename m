From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 23/24] input: Port hid-lg4ff to ff-memless-next
Date: Tue, 22 Apr 2014 16:00:08 +0200
Message-ID: <1398175209-9565-24-git-send-email-madcatxster@devoid-pointer.net>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

Port hid-lg4ff to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig     |  2 +-
 drivers/hid/hid-lg4ff.c | 93 ++++++++++++++++++++++++++++++-----------=
--------
 2 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8889b7a..5e6aa8e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -390,7 +390,7 @@ config LOGIG940_FF
 config LOGIWHEELS_FF
 	bool "Logitech wheels configuration and force feedback support"
 	depends on HID_LOGITECH
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	default LOGITECH_FF
 	help
 	  Say Y here if you want to enable force feedback and range setting
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 24883b4..d629093 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -25,6 +25,7 @@
=20
=20
 #include <linux/input.h>
+#include <linux/input/ff-memless-next.h>
 #include <linux/usb.h>
 #include <linux/hid.h>
=20
@@ -45,6 +46,8 @@
 #define G27_REV_MIN 0x38
 #define G27_2_REV_MIN 0x39
=20
+#define FF_UPDATE_RATE 8
+
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
=20
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
@@ -69,6 +72,13 @@ struct lg4ff_device_entry {
=20
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
+	FF_RAMP,
+	FF_PERIODIC,
+	FF_SQUARE,
+	FF_TRIANGLE,
+	FF_SINE,
+	FF_SAW_UP,
+	FF_SAW_DOWN,
 	FF_AUTOCENTER,
 	-1
 };
@@ -184,47 +194,60 @@ int lg4ff_adjust_input_event(struct hid_device *h=
id, struct hid_field *field,
 	}
 }
=20
-static int hid_lg4ff_play(struct input_dev *dev, void *data, struct ff=
_effect *effect)
+static int hid_lg4ff_start_combined(struct hid_device *hid, struct hid=
_report *report,
+				    const struct mlnx_simple_force *force)
+{
+	__s32 *value =3D report->field[0]->value;
+	int scaled_x;
+
+	/* Scale down from MLNX range */
+	scaled_x =3D 0x80 - (force->x * 0xff / 0xffff);
+
+	value[0] =3D 0x11;	/* Slot 1 */
+	value[1] =3D 0x08;
+	value[2] =3D scaled_x;
+	value[3] =3D 0x80;
+	value[4] =3D 0x00;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	return 0;
+}
+
+static int hid_lg4ff_stop_combined(struct hid_device *hid, struct hid_=
report *report)
+{
+	__s32 *value =3D report->field[0]->value;
+
+	value[0] =3D 0x13;	/* Slot 1 */
+	value[1] =3D 0x00;
+	value[2] =3D 0x00;
+	value[3] =3D 0x00;
+	value[4] =3D 0x00;
+	value[5] =3D 0x00;
+	value[6] =3D 0x00;
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	return 0;
+}
+
+static int hid_lg4ff_control(struct input_dev *dev, void *data, const =
struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	__s32 *value =3D report->field[0]->value;
-	int x;
-
-#define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0xf=
f; } while (0)
-
-	switch (effect->type) {
-	case FF_CONSTANT:
-		x =3D effect->u.ramp.start_level + 0x80;	/* 0x80 is no force */
-		CLAMP(x);
-
-		if (x =3D=3D 0x80) {
-			/* De-activate force in slot-1*/
-			value[0] =3D 0x13;
-			value[1] =3D 0x00;
-			value[2] =3D 0x00;
-			value[3] =3D 0x00;
-			value[4] =3D 0x00;
-			value[5] =3D 0x00;
-			value[6] =3D 0x00;
-
-			hid_hw_request(hid, report, HID_REQ_SET_REPORT);
-			return 0;
-		}
-
-		value[0] =3D 0x11;	/* Slot 1 */
-		value[1] =3D 0x08;
-		value[2] =3D x;
-		value[3] =3D 0x80;
-		value[4] =3D 0x00;
-		value[5] =3D 0x00;
-		value[6] =3D 0x00;
=20
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	switch (command->cmd) {
+	case MLNX_START_COMBINED:
+		return hid_lg4ff_start_combined(hid, report, &command->u.simple_forc=
e);
+		break;
+	case MLNX_STOP_COMBINED:
+		return hid_lg4ff_stop_combined(hid, report);
 		break;
+	default:
+		dbg_hid("Unsupported effect command");
+		return -EINVAL;
 	}
-	return 0;
 }
=20
 /* Sends default autocentering command compatible with
@@ -610,7 +633,7 @@ int lg4ff_init(struct hid_device *hid)
 	for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
 		set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, NULL, hid_lg4ff_play);
+	error =3D input_ff_create_mlnx(dev, (void *)NULL, hid_lg4ff_control, =
=46F_UPDATE_RATE);
=20
 	if (error)
 		return error;
--=20
1.9.2
