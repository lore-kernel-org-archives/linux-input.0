From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v4 13/24] hid: Port hid-lg3ff to ff-memless-next
Date: Sat, 26 Apr 2014 17:02:12 +0200
Message-ID: <1398524543-15012-14-git-send-email-madcatxster@devoid-pointer.net>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Port hid-lg3ff to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig     |  2 +-
 drivers/hid/hid-lg3ff.c | 60 +++++++++++++++++++++++++++++++----------=
--------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c4b0cbb..eb0c7f1 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -391,7 +391,7 @@ config LOGIRUMBLEPAD2_FF
 config LOGIG940_FF
 	bool "Logitech Flight System G940 force feedback support"
 	depends on HID_LOGITECH
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	help
 	  Say Y here if you want to enable force feedback support for Logitec=
h
 	  Flight System G940 devices.
diff --git a/drivers/hid/hid-lg3ff.c b/drivers/hid/hid-lg3ff.c
index 8c2da18..c49b374 100644
--- a/drivers/hid/hid-lg3ff.c
+++ b/drivers/hid/hid-lg3ff.c
@@ -23,9 +23,12 @@
=20
 #include <linux/input.h>
 #include <linux/hid.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-lg.h"
=20
+#define FF_UPDATE_RATE 50
+
 /*
  * G940 Theory of Operation (from experimentation)
  *
@@ -58,12 +61,11 @@ struct lg3ff_device {
 };
=20
 static int hid_lg3ff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+			 const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct list_head *report_list =3D &hid->report_enum[HID_OUTPUT_REPORT=
].report_list;
 	struct hid_report *report =3D list_entry(report_list->next, struct hi=
d_report, list);
-	int x, y;
=20
 /*
  * Available values in the field should always be 63, but we only use =
up to
@@ -72,30 +74,37 @@ static int hid_lg3ff_play(struct input_dev *dev, vo=
id *data,
 	memset(report->field[0]->value, 0,
 	       sizeof(__s32) * report->field[0]->report_count);
=20
-	switch (effect->type) {
-	case FF_CONSTANT:
-/*
- * Already clamped in ff_memless
- * 0 is center (different then other logitech)
- */
-		x =3D effect->u.ramp.start_level;
-		y =3D effect->u.ramp.end_level;
-
-		/* send command byte */
-		report->field[0]->value[0] =3D 0x51;
-
-/*
- * Sign backwards from other Force3d pro
- * which get recast here in two's complement 8 bits
- */
-		report->field[0]->value[1] =3D (unsigned char)(-x);
-		report->field[0]->value[31] =3D (unsigned char)(-y);
+	/* send command byte */
+	report->field[0]->value[0] =3D 0x51;
=20
-		hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+	switch (command->cmd) {
+	case MLNX_START_COMBINED: {
+		const struct mlnx_simple_force *simple_force =3D &command->u.simple_=
force;
+		/* Scale down from MLNX range */
+		const int x =3D simple_force->x * 0xff / 0xffff;
+		const int y =3D simple_force->y * 0xff / 0xffff;
+
+		/*
+		 * Sign backwards from other Force3d pro
+		 * which get recast here in two's complement 8 bits
+		*/
+		report->field[0]->value[1] =3D (unsigned char)x;
+		report->field[0]->value[31] =3D (unsigned char)y;
+		break;
+		}
+	case MLNX_STOP_COMBINED:
+		report->field[0]->value[1] =3D 0;
+		report->field[0]->value[31] =3D 0;
 		break;
+	default:
+		return -EINVAL;
 	}
+
+	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
+
 	return 0;
 }
+
 static void hid_lg3ff_set_autocenter(struct input_dev *dev, u16 magnit=
ude)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
@@ -123,6 +132,13 @@ static void hid_lg3ff_set_autocenter(struct input_=
dev *dev, u16 magnitude)
=20
 static const signed short ff3_joystick_ac[] =3D {
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
@@ -143,7 +159,7 @@ int lg3ff_init(struct hid_device *hid)
 	for (i =3D 0; ff_bits[i] >=3D 0; i++)
 		set_bit(ff_bits[i], dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, NULL, hid_lg3ff_play);
+	error =3D input_ff_create_mlnx(dev, NULL, hid_lg3ff_play, FF_UPDATE_R=
ATE);
 	if (error)
 		return error;
=20
--=20
1.9.2
