From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v4 11/24] hid: Port hid-holtekff to ff-memless-next
Date: Sat, 26 Apr 2014 17:02:10 +0200
Message-ID: <1398524543-15012-12-git-send-email-madcatxster@devoid-pointer.net>
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

Port hid-holtekff to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig        |  2 +-
 drivers/hid/hid-holtekff.c | 47 +++++++++++++++++++++++++++++---------=
--------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4c59a88..1749a4a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -256,7 +256,7 @@ config HID_HOLTEK
 config HOLTEK_FF
 	bool "Holtek On Line Grip force feedback support"
 	depends on HID_HOLTEK
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
index 9325545..9c6064d 100644
--- a/drivers/hid/hid-holtekff.c
+++ b/drivers/hid/hid-holtekff.c
@@ -27,9 +27,12 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
+
 #ifdef CONFIG_HOLTEK_FF
=20
 MODULE_LICENSE("GPL");
@@ -104,34 +107,44 @@ static void holtekff_send(struct holtekff_device =
*holtekff,
 }
=20
 static int holtekff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+			 const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct holtekff_device *holtekff =3D data;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int left, right;
 	/* effect type 1, length 65535 msec */
 	u8 buf[HOLTEKFF_MSG_LENGTH] =3D
 		{ 0x01, 0x01, 0xff, 0xff, 0x10, 0xe0, 0x00 };
=20
-	left =3D effect->u.rumble.strong_magnitude;
-	right =3D effect->u.rumble.weak_magnitude;
-	dbg_hid("called with 0x%04x 0x%04x\n", left, right);
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		left =3D rumble_force->strong;
+		right =3D rumble_force->weak;
+		dbg_hid("called with 0x%04x 0x%04x\n", left, right);
=20
-	if (!left && !right) {
-		holtekff_send(holtekff, hid, stop_all6);
-		return 0;
-	}
+		if (!left && !right) {
+			holtekff_send(holtekff, hid, stop_all6);
+			return 0;
+		}
=20
-	if (left)
-		buf[1] |=3D 0x80;
-	if (right)
-		buf[1] |=3D 0x40;
+		if (left)
+			buf[1] |=3D 0x80;
+		if (right)
+			buf[1] |=3D 0x40;
=20
-	/* The device takes a single magnitude, so we just sum them up. */
-	buf[6] =3D min(0xf, (left >> 12) + (right >> 12));
+		/* The device takes a single magnitude, so we just sum them up. */
+		buf[6] =3D min(0xf, (left >> 12) + (right >> 12));
=20
-	holtekff_send(holtekff, hid, buf);
-	holtekff_send(holtekff, hid, start_effect_1);
+		holtekff_send(holtekff, hid, buf);
+		holtekff_send(holtekff, hid, start_effect_1);
+		return 0;
+	case MLNX_STOP_RUMBLE:
+		holtekff_send(holtekff, hid, stop_all6);
+		return 0;
+	default:
+		return -EINVAL;
+	}
=20
 	return 0;
 }
@@ -171,7 +184,7 @@ static int holtekff_init(struct hid_device *hid)
 	holtekff_send(holtekff, hid, stop_all4);
 	holtekff_send(holtekff, hid, stop_all6);
=20
-	error =3D input_ff_create_memless(dev, holtekff, holtekff_play);
+	error =3D input_ff_create_mlnx(dev, holtekff, holtekff_play, FF_UPDAT=
E_RATE);
 	if (error) {
 		kfree(holtekff);
 		return error;
--=20
1.9.2
