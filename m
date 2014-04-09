From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 15/24] Port hid-sjoy to ff-memless-next
Date: Wed, 09 Apr 2014 13:26:28 +0200
Message-ID: <3417794.e4CZGoaz2f@sigyn>
References: <1609685.QRL9N9sQvX@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from transparentnimenzy.cz ([31.31.77.140]:52621 "EHLO
	devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015AbaDIL0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 07:26:32 -0400
In-Reply-To: <1609685.QRL9N9sQvX@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>

Port hid-sjoy to ff-memless-next

Signed-off-by: Michal Mal=FD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-sjoy.c | 35 +++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 87a02cc..e76c36a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -681,7 +681,7 @@ config HID_SMARTJOYPLUS
 config SMARTJOYPLUS_FF
 	bool "SmartJoy PLUS PS2/USB adapter force feedback support"
 	depends on HID_SMARTJOYPLUS
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
 	enable force feedback support for it.
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 37845ec..a6f8cfe 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -30,8 +30,11 @@
 #include <linux/slab.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input/ff-memless-next.h>
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
+
 #ifdef CONFIG_SMARTJOYPLUS_FF
=20
 struct sjoyff_device {
@@ -39,21 +42,33 @@ struct sjoyff_device {
 };
=20
 static int hid_sjoyff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+			const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct sjoyff_device *sjoyff =3D data;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	u32 left, right;
=20
-	left =3D effect->u.rumble.strong_magnitude;
-	right =3D effect->u.rumble.weak_magnitude;
-	dev_dbg(&dev->dev, "called with 0x%08x 0x%08x\n", left, right);
-
-	left =3D left * 0xff / 0xffff;
-	right =3D (right !=3D 0); /* on/off only */
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		left =3D rumble_force->strong;
+		right =3D rumble_force->weak;
+		dev_dbg(&dev->dev, "called with 0x%08x 0x%08x\n", left, right);
+
+		left =3D left * 0xff / 0xffff;
+		right =3D (right !=3D 0); /* on/off only */
+
+		sjoyff->report->field[0]->value[1] =3D right;
+		sjoyff->report->field[0]->value[2] =3D left;
+		break;
+	case MLNX_STOP_RUMBLE:
+		left =3D 0;
+		right =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
-	sjoyff->report->field[0]->value[1] =3D right;
-	sjoyff->report->field[0]->value[2] =3D left;
 	dev_dbg(&dev->dev, "running with 0x%02x 0x%02x\n", left, right);
 	hid_hw_request(hid, sjoyff->report, HID_REQ_SET_REPORT);
=20
@@ -103,7 +118,7 @@ static int sjoyff_init(struct hid_device *hid)
=20
 		set_bit(FF_RUMBLE, dev->ffbit);
=20
-		error =3D input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
+		error =3D input_ff_create_mlnx(dev, sjoyff, hid_sjoyff_play, FF_UPDA=
TE_RATE);
 		if (error) {
 			kfree(sjoyff);
 			return error;
--=20
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
