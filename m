From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 12/24] hid: Port hid-lgff to ff-memless-next
Date: Sat, 26 Apr 2014 13:57:49 +0200
Message-ID: <1398513696-12626-13-git-send-email-madcatxster@devoid-pointer.net>
References: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Port hid-lgff to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-lgff.c | 70 +++++++++++++++++++++++++++++++++++-------=
--------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1749a4a..c4b0cbb 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -365,7 +365,7 @@ config HID_LOGITECH_DJ
 config LOGITECH_FF
 	bool "Logitech force feedback support"
 	depends on HID_LOGITECH
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  Say Y here if you have one of these devices:
 	  - Logitech WingMan Cordless RumblePad
diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
index e1394af..40ad68a 100644
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
@@ -47,11 +50,25 @@ static const signed short ff_rumble[] =3D {
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
 static const signed short ff_joystick_ac[] =3D {
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
@@ -66,45 +83,58 @@ static const struct dev_type devices[] =3D {
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
+		const int y =3D 0x80 - (simple_force->y * 0xff / 0xffff);
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
+		report->field[0]->value[2] =3D 0x80;
+		report->field[0]->value[3] =3D 0x80;
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
@@ -148,7 +178,7 @@ int lgff_init(struct hid_device* hid)
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
1.9.2
