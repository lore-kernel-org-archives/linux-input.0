From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 08/24] Port hid-emsff to ff-memless-next
Date: Tue, 22 Apr 2014 15:45:58 +0200
Message-ID: <1398174374-9501-9-git-send-email-madcatxster@devoid-pointer.net>
References: <1398174374-9501-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from transparentnimenzy.cz ([31.31.77.140]:49414 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419AbaDVNqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 09:46:35 -0400
In-Reply-To: <1398174374-9501-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig     |  2 +-
 drivers/hid/hid-emsff.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 68c19a0..6e233d2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -204,7 +204,7 @@ config DRAGONRISE_FF
 config HID_EMS_FF
 	tristate "EMS Production Inc. force feedback support"
 	depends on HID
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you want to enable force feedback support for devices b=
y
 	EMS Production Ltd.
diff --git a/drivers/hid/hid-emsff.c b/drivers/hid/hid-emsff.c
index d82d75b..c0cbe50 100644
--- a/drivers/hid/hid-emsff.c
+++ b/drivers/hid/hid-emsff.c
@@ -24,30 +24,44 @@
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
+#define FF_UPDATE_RATE 50
+
 struct emsff_device {
 	struct hid_report *report;
 };
=20
 static int emsff_play(struct input_dev *dev, void *data,
-			 struct ff_effect *effect)
+			 const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct emsff_device *emsff =3D data;
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int weak, strong;
=20
-	weak =3D effect->u.rumble.weak_magnitude;
-	strong =3D effect->u.rumble.strong_magnitude;
-
-	dbg_hid("called with 0x%04x 0x%04x\n", strong, weak);
-
-	weak =3D weak * 0xff / 0xffff;
-	strong =3D strong * 0xff / 0xffff;
-
-	emsff->report->field[0]->value[1] =3D weak;
-	emsff->report->field[0]->value[2] =3D strong;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		weak =3D rumble_force->weak;
+		strong =3D rumble_force->strong;
+
+		dbg_hid("called with 0x%04x 0x%04x\n", strong, weak);
+
+		weak =3D weak * 0xff / 0xffff;
+		strong =3D strong * 0xff / 0xffff;
+
+		emsff->report->field[0]->value[1] =3D weak;
+		emsff->report->field[0]->value[2] =3D strong;
+		break;
+	case MLNX_STOP_RUMBLE:
+		weak =3D 0;
+		strong =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	dbg_hid("running with 0x%02x 0x%02x\n", strong, weak);
 	hid_hw_request(hid, emsff->report, HID_REQ_SET_REPORT);
@@ -88,7 +102,7 @@ static int emsff_init(struct hid_device *hid)
=20
 	set_bit(FF_RUMBLE, dev->ffbit);
=20
-	error =3D input_ff_create_memless(dev, emsff, emsff_play);
+	error =3D input_ff_create_mlnx(dev, emsff, emsff_play, FF_UPDATE_RATE=
);
 	if (error) {
 		kfree(emsff);
 		return error;
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
