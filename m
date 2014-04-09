From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 12/24] Port hid-lgff to ff-memless-next
Date: Wed, 09 Apr 2014 13:24:02 +0200
Message-ID: <1533887.5nzvy1GCXV@sigyn>
References: <1609685.QRL9N9sQvX@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devoid-pointer.net ([31.31.77.140]:52610 "EHLO
	devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbaDILYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 07:24:06 -0400
In-Reply-To: <1609685.QRL9N9sQvX@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>

Port hid-lgff to ff-memless-next

Signed-off-by: Michal Mal=FD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-lgff.c | 63 ++++++++++++++++++++++++++++++++++--------=
--------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d1d4e77..c7794ae 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -356,7 +356,7 @@ config HID_LOGITECH_DJ
 config LOGITECH_FF
 	bool "Logitech force feedback support"
 	depends on HID_LOGITECH
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  Say Y here if you have one of these devices:
 	  - Logitech WingMan Cordless RumblePad
diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index e1394af..b929a3a 100644
--- a/drivers/hid/hid-lgff.c
+++ b/drivers/hid/hid-lgff.c
@@ -31,9 +31,12 @@
=20
 #include <linux/input.h>
 #include <linux/hid.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-lg.h"
=20
+#define FF_UPDATE_RATE 50
+
 struct dev_type {
 	u16 idVendor;
 	u16 idProduct;
@@ -47,6 +50,13 @@ static const signed short ff_rumble[] =3D {
=20
 static const signed short ff_joystick[] =3D {
 	FF_CONSTANT,
+	FF_RAMP,
+	FF_PERIODIC,
+	FF_SQUARE,
+	FF_TRIANGLE,
+	FF_SINE,
+	FF_SAW_UP,
+	FF_SAW_DOWN,
 	-1
 };
=20
@@ -66,45 +76,58 @@ static const struct dev_type devices[] =3D {
 	{ 0x046d, 0xc295, ff_joystick },
 };
=20
-static int hid_lgff_play(struct input_dev *dev, void *data, struct ff_=
effect *effect)
+static int hid_lgff_play(struct input_dev *dev, void *data,
+			 const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	int x, y;
-	unsigned int left, right;
=20
-#define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
+	switch (command->cmd) {
+	case MLNX_START_COMBINED: {
+		const struct mlnx_simple_force *simple_force =3D &command->u.simple_=
force;
+		/* Scale down from MLNX range */
+		const int x =3D 0x80 - (simple_force->x * 0xff / 0xffff);
+		const int y =3D simple_force->y * 0xff / 0xffff;
=20
-	switch (effect->type) {
-	case FF_CONSTANT:
-		x =3D effect->u.ramp.start_level + 0x7f;	/* 0x7f is center */
-		y =3D effect->u.ramp.end_level + 0x7f;
-		CLAMP(x);
-		CLAMP(y);
 		report->field[0]->value[0] =3D 0x51;
 		report->field[0]->value[1] =3D 0x08;
 		report->field[0]->value[2] =3D x;
 		report->field[0]->value[3] =3D y;
 		dbg_hid("(x, y)=3D(%04x, %04x)\n", x, y);
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 		break;
+	}
+	case MLNX_STOP_COMBINED:
+		report->field[0]->value[0] =3D 0x51;
+		report->field[0]->value[1] =3D 0x08;
+		report->field[0]->value[2] =3D 0;
+		report->field[0]->value[3] =3D 0;
+		break;
+	case MLNX_START_RUMBLE: {
+		const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_=
force;
+		/* Scale down from MLNX range */
+		const unsigned int right =3D rumble_force->weak * 0xff / 0xffff;
+		const unsigned int left =3D rumble_force->strong * 0xff / 0xffff;
=20
-	case FF_RUMBLE:
-		right =3D effect->u.rumble.strong_magnitude;
-		left =3D effect->u.rumble.weak_magnitude;
-		right =3D right * 0xff / 0xffff;
-		left =3D left * 0xff / 0xffff;
-		CLAMP(left);
-		CLAMP(right);
 		report->field[0]->value[0] =3D 0x42;
 		report->field[0]->value[1] =3D 0x00;
 		report->field[0]->value[2] =3D left;
 		report->field[0]->value[3] =3D right;
 		dbg_hid("(left, right)=3D(%04x, %04x)\n", left, right);
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 		break;
 	}
+	case MLNX_STOP_RUMBLE:
+		report->field[0]->value[0] =3D 0x42;
+		report->field[0]->value[1] =3D 0x00;
+		report->field[0]->value[2] =3D 0;
+		report->field[0]->value[3] =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+
 	return 0;
 }
=20
@@ -148,7 +171,7 @@ int lgff_init(struct hid_device* hid)
 	for (i =3D 0; ff_bits[i] >=3D 0; i++)
 		set_bit(ff_bits[i], dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, NULL, hid_lgff_play);
+	error =3D input_ff_create_mlnx(dev, NULL, hid_lgff_play, FF_UPDATE_RA=
TE);
 	if (error)
 		return error;
=20
--=20
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
