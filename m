From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH v2 2/4] Port hid-lg4ff to ff-memless-next
Date: Mon, 24 Feb 2014 00:32:23 +0100
Message-ID: <1646498.7GVfWfMn8D@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:41495 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbaBWXcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 18:32:25 -0500
In-Reply-To: <1516865.M993BQAYe4@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, anssi.hannula@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

Port hid-lg4ff to ff-memless-next

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
 v2: Differentiate between "set force to zero" and "stop force complete=
ly"

 drivers/hid/Kconfig     |  2 +-
 drivers/hid/hid-lg4ff.c | 86 +++++++++++++++++++++++++++++------------=
--------
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f722001..11ac17e 100644
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
index befe0e3..95d2a9f 100644
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
@@ -44,6 +45,8 @@
 #define G27_REV_MAJ 0x12
 #define G27_REV_MIN 0x38
=20
+#define FF_UPDATE_RATE 8
+
 #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
=20
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range)=
;
@@ -182,47 +185,60 @@ int lg4ff_adjust_input_event(struct hid_device *h=
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
@@ -608,7 +624,7 @@ int lg4ff_init(struct hid_device *hid)
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
1.9.0


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
