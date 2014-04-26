From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 09/24] hid: Port hid-dr to ff-memless-next
Date: Sat, 26 Apr 2014 13:57:46 +0200
Message-ID: <1398513696-12626-10-git-send-email-madcatxster@devoid-pointer.net>
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

Port hid-dr to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig  |  2 +-
 drivers/hid/hid-dr.c | 59 ++++++++++++++++++++++++++++++++------------=
--------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a78b5d8..1d4180c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -205,7 +205,7 @@ config HID_DRAGONRISE
 config DRAGONRISE_FF
 	bool "DragonRise Inc. force feedback"
 	depends on HID_DRAGONRISE
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you want to enable force feedback support for DragonRis=
e Inc.
 	game controllers.
diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index ce06444..b95c676 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -31,8 +31,10 @@
 #include <linux/slab.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
+#define FF_UPDATE_RATE 50
=20
 #ifdef CONFIG_DRAGONRISE_FF
=20
@@ -41,38 +43,49 @@ struct drff_device {
 };
=20
 static int drff_play(struct input_dev *dev, void *data,
-				 struct ff_effect *effect)
+			const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct drff_device *drff =3D data;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int strong, weak;
=20
-	strong =3D effect->u.rumble.strong_magnitude;
-	weak =3D effect->u.rumble.weak_magnitude;
+	strong =3D rumble_force->strong;
+	weak =3D rumble_force->weak;
=20
 	dbg_hid("called with 0x%04x 0x%04x", strong, weak);
=20
-	if (strong || weak) {
-		strong =3D strong * 0xff / 0xffff;
-		weak =3D weak * 0xff / 0xffff;
-
-		/* While reverse engineering this device, I found that when
-		   this value is set, it causes the strong rumble to function
-		   at a near maximum speed, so we'll bypass it. */
-		if (weak =3D=3D 0x0a)
-			weak =3D 0x0b;
-
-		drff->report->field[0]->value[0] =3D 0x51;
-		drff->report->field[0]->value[1] =3D 0x00;
-		drff->report->field[0]->value[2] =3D weak;
-		drff->report->field[0]->value[4] =3D strong;
-		hid_hw_request(hid, drff->report, HID_REQ_SET_REPORT);
-
-		drff->report->field[0]->value[0] =3D 0xfa;
-		drff->report->field[0]->value[1] =3D 0xfe;
-	} else {
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		if (strong || weak) {
+			strong =3D strong * 0xff / 0xffff;
+			weak =3D weak * 0xff / 0xffff;
+
+			/* While reverse engineering this device, I found that when
+			this value is set, it causes the strong rumble to function
+			at a near maximum speed, so we'll bypass it. */
+			if (weak =3D=3D 0x0a)
+				weak =3D 0x0b;
+
+			drff->report->field[0]->value[0] =3D 0x51;
+			drff->report->field[0]->value[1] =3D 0x00;
+			drff->report->field[0]->value[2] =3D weak;
+			drff->report->field[0]->value[4] =3D strong;
+			hid_hw_request(hid, drff->report, HID_REQ_SET_REPORT);
+
+			drff->report->field[0]->value[0] =3D 0xfa;
+			drff->report->field[0]->value[1] =3D 0xfe;
+		} else {
+			drff->report->field[0]->value[0] =3D 0xf3;
+			drff->report->field[0]->value[1] =3D 0x00;
+		}
+		break;
+	case MLNX_STOP_RUMBLE:
 		drff->report->field[0]->value[0] =3D 0xf3;
 		drff->report->field[0]->value[1] =3D 0x00;
+		break;
+	default:
+		return -EINVAL;
 	}
=20
 	drff->report->field[0]->value[2] =3D 0x00;
@@ -116,7 +129,7 @@ static int drff_init(struct hid_device *hid)
=20
 	set_bit(FF_RUMBLE, dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, drff, drff_play);
+	error =3D input_ff_create_mlnx(dev, drff, drff_play, FF_UPDATE_RATE);
 	if (error) {
 		kfree(drff);
 		return error;
--=20
1.9.2
