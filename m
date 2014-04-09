From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 07/24] Port hid-axff to ff-memless-next
Date: Wed, 09 Apr 2014 13:18:51 +0200
Message-ID: <1620862.YaQ9IaA2dH@sigyn>
References: <1609685.QRL9N9sQvX@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devoid-pointer.net ([31.31.77.140]:52591 "EHLO
	devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560AbaDILSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 07:18:55 -0400
In-Reply-To: <1609685.QRL9N9sQvX@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>

Port hid-axff to ff-memless-next

Signed-off-by: Michal Mal=FD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-axff.c | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f722001..68c19a0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -106,7 +106,7 @@ config HID_ACRUX
 config HID_ACRUX_FF
 	bool "ACRUX force feedback support"
 	depends on HID_ACRUX
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you want to enable force feedback support for ACRUX
 	game controllers.
diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index a594e47..7fbfcbc 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -31,31 +31,45 @@
 #include <linux/slab.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
 #ifdef CONFIG_HID_ACRUX_FF
=20
 struct axff_device {
 	struct hid_report *report;
 };
=20
-static int axff_play(struct input_dev *dev, void *data, struct ff_effe=
ct *effect)
+static int axff_play(struct input_dev *dev, void *data,
+		     const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct axff_device *axff =3D data;
 	struct hid_report *report =3D axff->report;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int field_count =3D 0;
 	int left, right;
 	int i, j;
=20
-	left =3D effect->u.rumble.strong_magnitude;
-	right =3D effect->u.rumble.weak_magnitude;
-
-	dbg_hid("called with 0x%04x 0x%04x", left, right);
-
-	left =3D left * 0xff / 0xffff;
-	right =3D right * 0xff / 0xffff;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		left =3D rumble_force->strong;
+		right =3D rumble_force->weak;
+
+		dbg_hid("called with 0x%04x 0x%04x", left, right);
+
+		left =3D left * 0xff / 0xffff;
+		right =3D right * 0xff / 0xffff;
+		break;
+	case MLNX_STOP_RUMBLE:
+		left =3D 0;
+		right =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	for (i =3D 0; i < report->maxfield; i++) {
 		for (j =3D 0; j < report->field[i]->report_count; j++) {
@@ -107,7 +121,7 @@ static int axff_init(struct hid_device *hid)
=20
 	set_bit(FF_RUMBLE, dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, axff, axff_play);
+	error =3D input_ff_create_mlnx(dev, axff, axff_play, FF_UPDATE_RATE);
 	if (error)
 		goto err_free_mem;
=20
--=20
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
